//
//  BalanceReceiveOperation.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/21/22.
//

import Foundation


/// This class will be responsible for receive balance (add balance in existing currency )
struct BalanceReceiveOperation: BalanceOperation {
    func execute(exchangeBalance: CurrencyExchange, balances: [Balance], commission: Double) -> [Balance] {
        var balances = balances
        let receiveCurrency = (exchangeBalance.receive?.currency).unwrappedValue
        let receiveAmount = (exchangeBalance.receive?.amount).unwrappedValue
        
        // set recieve amount
        if let index = balances.firstIndex(where: { ($0.currency?.elementsEqual(receiveCurrency)).unwrappedValue }) {
            balances[index].amount = (balances[index].amount).unwrappedValue + receiveAmount
        }
        
        return balances
    }
}
