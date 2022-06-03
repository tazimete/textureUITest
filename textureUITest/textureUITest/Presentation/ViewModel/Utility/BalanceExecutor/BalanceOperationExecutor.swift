//
//  BalanceCalculator.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/20/22.
//

import Foundation


/// BalanceOperationExecutor
/// - This class will be responsible for execute balance operation 
class BalanceOperationExecutor {
    private(set) var operation: BalanceOperation
    
    init(operation: BalanceOperation) {
        self.operation = operation
    }
    
    func update(operation: BalanceOperation) {
        self.operation = operation
    }
    
    // check enough balance before exchange
    func executeCheck(exchangeBalance: CurrencyExchange, balances: [Balance], commission: Double) -> Bool {
        return operation.check(exchangeBalance: exchangeBalance, balances: balances, commission: commission)
    }
    
    // deduct and increase balance after exchange
    func executeBalance(exchangeBalance: CurrencyExchange, balances: [Balance], commission: Double) -> [Balance] {
        return operation.execute(exchangeBalance: exchangeBalance, balances: balances, commission: commission)
    }
}
