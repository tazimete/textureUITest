//
//  Movie.swift
//  currency-converter
//
//  Created by AGM Tazimon 31/10/21.
//

import Foundation

/* Balance entity of presentation/application layer */
struct Balance: AbstractDataModel, Codable, Equatable {
    public var id: Int?
    public var amount: Double?
    public var currency: String?
    
    init(amount: Double? = nil, currency: String? = nil) {
        self.amount = amount
        self.currency = currency
    }
    
    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case currency = "currency"
    }
    
    public var asDictionary : [String: Any] {
        return [CodingKeys.amount.rawValue: amount ?? "", CodingKeys.currency.rawValue: currency ?? ""]
    }
    
    public var asCellViewModel: AbstractCellViewModel {
        var viewModel = CurrencyCellViewModel(title: "\(currency ?? "")")
        
        if let amount = amount {
            viewModel = CurrencyCellViewModel(title: "\(amount.round(to: 2)) \(currency ?? "")")
        }
        
        return viewModel 
    }
    
    static func ==(lhs: Balance, rhs: Balance) -> Bool {
        return lhs.currency.unwrappedValue == rhs.currency.unwrappedValue && lhs.amount.unwrappedValue == rhs.amount.unwrappedValue
    }
}


extension Optional where Wrapped == Balance {
    var unwrappedValue: Balance {
        return self ?? Balance()
    }
}
