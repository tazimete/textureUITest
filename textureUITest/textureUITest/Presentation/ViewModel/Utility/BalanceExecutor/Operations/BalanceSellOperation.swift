//
//  BalanceSellOperation.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/21/22.
//

import Foundation


/// BalanceSellOperation - This class will deduct balance which is being sold 
struct BalanceSellOperation: BalanceOperation {
    func execute(exchangeBalance: CurrencyExchange, balances: [Balance], commission: Double) -> [Balance] {
        var balances = balances
        let sellCurrency = (exchangeBalance.sell?.currency).unwrappedValue
        let sellAmount = (exchangeBalance.sell?.amount).unwrappedValue
        
        //set deduct amount from sell balance
        if let index = balances.firstIndex(where: { ($0.currency?.elementsEqual(sellCurrency)).unwrappedValue}) {
            balances[index].amount = (balances[index].amount).unwrappedValue - sellAmount - commission
        }
        
        return balances
    }
}
