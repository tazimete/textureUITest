//
//  GithubUserParams.swift
//  currency-converter
//
//  Created by AGM Tazimon 24/7/21.
//

import Foundation


struct CurrencyConverterParams: Parameterizable {
    let fromAmount: String
    let fromCurrency: String
    let toCurrency: String

    public init(fromAmount: String, fromCurrency: String, toCurrency: String) {
        self.fromAmount = fromAmount
        self.fromCurrency = fromCurrency
        self.toCurrency = toCurrency
    }

    public enum CodingKeys: String, CodingKey {
        case fromAmount = "fromAmount"
        case fromCurrency = "fromCurrency"
        case toCurrency = "toCurrency"
    }

    public var asRequestParam: [String: Any] {
        let param: [String: Any] = [CodingKeys.fromAmount.rawValue: fromAmount, CodingKeys.fromCurrency.rawValue: fromCurrency, CodingKeys.toCurrency.rawValue: toCurrency]
        return param.compactMapValues { $0 }
    }
}
