//
//  Balance.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/18/22.
//

import Foundation


/* Currency entity of api response */
struct Currency: Codable, Equatable {
    public let amount: String?
    public let title: String?
    
    init(amount: String? = nil, title: String? = nil) {
        self.amount = amount
        self.title = title
    }
    
    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case title = "currency"
    }
    
    static func ==(lhs: Currency, rhs: Currency) -> Bool {
        return lhs.amount.unwrappedValue == rhs.amount.unwrappedValue && lhs.title.unwrappedValue == rhs.title.unwrappedValue
    }
}


extension Optional where Wrapped == Currency {
    var unwrappedValue: Currency {
        return self ?? Currency()
    }
}
