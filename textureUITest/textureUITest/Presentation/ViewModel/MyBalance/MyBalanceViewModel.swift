//
//  MyBalanceViewModel.swift
//  currency-converter
//
//  Created by AGM Tazim on 30/10/21.
//

import Foundation
import RxSwift
import RxCocoa

/* This is my balance viewmodel class implementation of AbstractMyBalanceViewModel. Which will be used to get my blalance related data by its usecase*/
class MyBalanceViewModel: AbstractMyBalanceViewModel {
    
    // This struct will be used get input from viewcontroller
    public struct CurrencyConverterInput {
        let fromAmount: String
        let fromCurrency: String
        let toCurrency: String
    }
    
    // This struct will be used get event with data from viewcontroller
    public struct MyBalanceInput {
        let currencyConverterTrigger: Observable<CurrencyConverterInput>
        let addCurrencyTrigger: Observable<Balance>
    }
    
    // This struct will be used to send event with observable data/response to viewcontroller
    public struct MyBalanceOutput {
        let balance: BehaviorRelay<Balance?>
        let validationError: BehaviorRelay<ValidationError?>
        let errorResponse: BehaviorRelay<NetworkError?>
    }
    
    let disposeBag =  DisposeBag()
    let entityFactory: EntityFactory
    let usecase: AbstractUsecase
    let commissionCalculator: ComissionCalculator
    let balanceExecutor: BalanceOperationExecutor
    let currencyExchange: CurrencyExchange = CurrencyExchange()
    let balanceListRelay: BehaviorRelay<[Balance]> = BehaviorRelay<[Balance]>(value: [])
    
    
    public init(usecase: AbstractCurrencyUsecase, commissionCalculator: ComissionCalculator, balanceExecutor: BalanceOperationExecutor, entityFactory: EntityFactory = EntityFactory()) {
        self.usecase = usecase
        self.commissionCalculator = commissionCalculator
        self.balanceExecutor = balanceExecutor
        self.entityFactory = entityFactory
        self.balanceListRelay.accept((entityFactory.createList(type: .balance) as? [Balance]) ?? [])
    }
    
    public func getMyBalanceOutput(input: MyBalanceInput) -> MyBalanceOutput {
        let balanceResponse = BehaviorRelay<Balance?>(value: nil)
        let validationError = BehaviorRelay<ValidationError?>(value: nil)
        let errorResponse = BehaviorRelay<NetworkError?>(value: nil) 
        
        //add currency trigger
        input.addCurrencyTrigger
            .subscribe(onNext: { [weak self] balance in
                guard let weakSelf = self else {
                    return
                }
                
                let values = weakSelf.balanceListRelay.value
                weakSelf.balanceListRelay.accept(values + [balance])
        }).disposed(by: disposeBag)
        
        // currency exchange trigger
        input.currencyConverterTrigger.flatMapLatest({ [weak self] (inputModel) -> Observable<CurrencyApiRequest.ItemType> in
            // check if  self is exists and balance is enough
            guard let weakSelf = self else {
                return Observable.just(CurrencyApiRequest.ItemType())
            }
            
            // check enough balance before proceed
            guard weakSelf.hasEnoughBalance() == true else {
                validationError.accept(ValidationError.notEnoughBalance(code: 101, message: "You dont have enough balance to exchange include \(weakSelf.commissionCalculator.commissionOptions.comissionAmountInPercent)% comission"))
                return Observable.just(CurrencyApiRequest.ItemType())
            }
            
            //convert currency with balance
            return weakSelf.convert(fromAmount: inputModel.fromAmount, fromCurrency: inputModel.fromCurrency, toCurrency: inputModel.toCurrency)
                   .catch({ error in
                       errorResponse.accept(error as? NetworkError)
                       return Observable.just(CurrencyApiRequest.ItemType())
                    })
        })
        .observe(on: ConcurrentDispatchQueueScheduler(qos: .utility))
        .subscribe(onNext: { [weak self] response in
            guard let weakSelf = self, let amount = response.amount, let currency = response.title else {
                return
            }
            
            let output = Balance(amount: Double(amount).unwrappedValue, currency: currency)
            weakSelf.currencyExchange.receive = output
            weakSelf.balanceListRelay.accept(weakSelf.calculatFinalBalances())
            balanceResponse.accept(output)
        }, onError: { [weak self] error in
            errorResponse.accept(error as? NetworkError)
        }).disposed(by: disposeBag)
        
        return MyBalanceOutput.init(balance: balanceResponse, validationError: validationError, errorResponse: errorResponse)
    }
    
    // MARK: API CALLS
    func convert(fromAmount: String, fromCurrency: String, toCurrency: String) -> Observable<CurrencyApiRequest.ItemType> {
        return (usecase as! AbstractCurrencyUsecase).convert(fromAmount: fromAmount, fromCurrency: fromCurrency, toCurrency: toCurrency)
    }
    
    // MARK: HELPER METHODS
    // check if balance is enough before exchange 
    func hasEnoughBalance() -> Bool {
        balanceExecutor.update(operation: BalanceCheckOperation())
        return balanceExecutor.executeCheck(exchangeBalance: currencyExchange, balances: balanceListRelay.value, commission: calculateCommission())
    }
    
    // calculate commission before exchange
    func calculateCommission() -> Double {
        let commission = commissionCalculator.calculateCommissionAmount(conversionSerial: UserSessionDataClient.shared.conversionCount, conversionAmount: (currencyExchange.sell?.amount).unwrappedValue)
        
        AppLogger.info("Commission = \(commission)")
        
        return commission
    }
    
    // calculate total balance
    func calculatFinalBalances() -> [Balance] {
        balanceExecutor.update(operation: BalanceSellOperation())
        let updatedBalancesBySell = balanceExecutor.executeBalance(exchangeBalance: currencyExchange, balances: balanceListRelay.value, commission: calculateCommission())
        
        balanceExecutor.update(operation: BalanceReceiveOperation())
        let updatedBalancesByReceive = balanceExecutor.executeBalance(exchangeBalance: currencyExchange, balances: updatedBalancesBySell, commission: calculateCommission())
        
        return updatedBalancesByReceive
    }
}


public enum ValidationError: Error {
    case notEnoughBalance(code: Int, message: String)
    case none
    
    public var errorMessage: String {
        switch self {
        case .notEnoughBalance(_, let message):
            return message
        case .none:
            return ""
        }
    }
    
    public var errorCode: Int {
        switch self {
        case .notEnoughBalance(let code, _):
            return code
        case .none:
            return 0
        }
    }
}
