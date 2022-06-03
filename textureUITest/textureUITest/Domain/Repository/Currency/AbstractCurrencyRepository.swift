//
//  AbstractCurrencyRepository.swift
//  currency-converter
//
//  Created by AGM Tazim on 30/10/21.
//

import Foundation
import RxSwift

/* This is Currency repository abstraction extented from AbstractRepository. Which will be used to get currency related data from api client/server response*/
protocol AbstractCurrencyRepository: AbstractRepository {
     func get(fromAmount: String, fromCurrency: String, toCurrency: String) -> Observable<CurrencyApiRequest.ItemType>
}
