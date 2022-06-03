//
//  BalanceCalculatable.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/21/22.
//

import Foundation



/// BalanceOperation
/// - This is the abstraction of all type of balance operation. It will calculate balance, check balance and abalance info 
protocol BalanceOperation {
    // check balance by entity
    func check(exchangeBalance: CurrencyExchange, balances: [Balance], commission: Double) -> Bool
    
    //execute balance operation like - balance deduction and add 
    func execute(exchangeBalance: CurrencyExchange, balances: [Balance], commission: Double) -> [Balance]
}

extension BalanceOperation {
    func check(exchangeBalance: CurrencyExchange, balances: [Balance], commission: Double) -> Bool {
        return true
    }
    
    func execute(exchangeBalance: CurrencyExchange, balances: [Balance], commission: Double) -> [Balance] {
        return []
    }
}

