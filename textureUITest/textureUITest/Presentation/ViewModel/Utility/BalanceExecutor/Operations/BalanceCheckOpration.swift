//
//  BalanceCheckOpration.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/21/22.
//

import Foundation


/// BalanceCheckOperation - This class is responsible for balance chek operation
/// - Parameters:
/// 
struct BalanceCheckOperation: BalanceOperation {
    func check(exchangeBalance: CurrencyExchange, balances: [Balance], commission: Double) -> Bool {
        var result = true
        let currency = (exchangeBalance.sell?.currency).unwrappedValue
        let amount = (exchangeBalance.sell?.amount).unwrappedValue
        
        //check in all available balances
        if let index = balances.firstIndex(where: { ($0.currency?.elementsEqual(currency)).unwrappedValue}) {
            let diff = balances[index].amount.unwrappedValue - amount - commission
            result = diff >= 0 ? true : false
        }
        
        return result
    }
}


