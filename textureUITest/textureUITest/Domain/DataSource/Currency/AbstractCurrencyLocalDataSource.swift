//
//  CurrencyLocalDataSource.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/13/22.
//

import Foundation
import RxSwift


/* This is Currency local data source abstraction extented from AbstractLocalDataSource. Which will be used to get currency related data from currency database*/
protocol AbstractCurrencyLocalDataSource: AbstractLocalDataSource {
    func get(fromAmount: String, fromCurrency: String, toCurrency: String) -> Observable<CurrencyApiRequest.ItemType>
}
