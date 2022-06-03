//
//  CurrencyRepository.swift
//  currency-converter
//
//  Created by AGM Tazim on 30/10/21.
//

import Foundation
import RxSwift

/* This is Currency repository class implementation from AbstractCurrencyRepository. Which will be used to get currency related data from api client/server response*/
class CurrencyRepository: AbstractCurrencyRepository {
    let localDataSource: AbstractLocalDataSource
    let remoteDataSource: AbstractRemoteDataSource
    
    init(localDataSource: AbstractLocalDataSource, remoteDataSource: AbstractRemoteDataSource) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
    
    func get(fromAmount: String, fromCurrency: String, toCurrency: String) -> Observable<CurrencyApiRequest.ItemType> {
        return (remoteDataSource as! AbstractCurrencyRemoteDataSource).get(fromAmount: fromAmount, fromCurrency: fromCurrency, toCurrency: toCurrency)
    }
}
