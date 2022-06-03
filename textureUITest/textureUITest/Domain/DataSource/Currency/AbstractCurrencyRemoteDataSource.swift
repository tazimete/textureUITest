//
//  CurrencyRemoteDataSource.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/13/22.
//

import Foundation
import RxSwift

/* This is Currency remote data source abstraction extented from AbstractRemoteDataSource. Which will be used to get currency related data from currency api*/
protocol AbstractCurrencyRemoteDataSource: AbstractRemoteDataSource {
    func get(fromAmount: String, fromCurrency: String, toCurrency: String) -> Observable<CurrencyApiRequest.ItemType>
}
