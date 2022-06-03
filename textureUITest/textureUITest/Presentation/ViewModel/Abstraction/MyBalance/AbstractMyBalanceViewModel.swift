//
//  AbstractMyBalanceViewModel.swift
//  currency-converter
//
//  Created by AGM Tazim on 31/10/21.
//


import Foundation
import RxSwift
import RxRelay

/* This is AbstractMyBalanceViewModel abstraction extented from AbstractViewModel. Which will be used to get balance related data by its usecases*/
protocol AbstractMyBalanceViewModel: AbstractViewModel {
    associatedtype MyBalanceInput
    associatedtype MyBalanceOutput
    
    var disposeBag: DisposeBag {get}
    var entityFactory: EntityFactory {get}
    var commissionCalculator: ComissionCalculator {get}
    var balanceExecutor: BalanceOperationExecutor {get}
    var balanceListRelay: BehaviorRelay<[Balance]> {get}
    
    // Transform the my balance input to output observable
    func getMyBalanceOutput(input: MyBalanceInput) -> MyBalanceOutput
    
    // convert currency through api call
    func convert(fromAmount: String, fromCurrency: String, toCurrency: String) -> Observable<CurrencyApiRequest.ItemType>
    
    // check if balance is enough before exchange 
    func hasEnoughBalance() -> Bool
    
    //calculate commission before exchange
    func calculateCommission() -> Double
    
    // deduct and increase balance after exchange
    func calculatFinalBalances() -> [Balance]
}


