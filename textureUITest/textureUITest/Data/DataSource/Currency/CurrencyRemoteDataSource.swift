//
//  CurrencyRemoteDataSource.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/14/22.
//

import Foundation
import RxSwift

class CurrencyRemoteDataSource: AbstractCurrencyRemoteDataSource {
    let apiClient: AbstractApiClient
    
    init(apiClient: AbstractApiClient) {
        self.apiClient = apiClient
    }
    
    func get(fromAmount: String, fromCurrency: String, toCurrency: String) -> Observable<CurrencyApiRequest.ItemType> {
        return apiClient.send(apiRequest: CurrencyApiRequest.convert(params: CurrencyConverterParams(fromAmount: fromAmount, fromCurrency: fromCurrency, toCurrency: toCurrency)), type: CurrencyApiRequest.ItemType.self)
    }
}
