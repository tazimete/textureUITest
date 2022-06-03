//
//  CurrencyExchange.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/18/22.
//

import Foundation

class CurrencyExchange {
    var sell: Balance?
    var receive: Balance?
    
    init(sell: Balance? = nil, receive: Balance? = nil) {
        self.sell = sell
        self.receive = receive
    }
}
