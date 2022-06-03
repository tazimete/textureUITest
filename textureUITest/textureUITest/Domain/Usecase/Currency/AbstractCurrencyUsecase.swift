//
//  AbstractCurrencyUsecase.swift
//  currency-converter
//
//  Created by AGM Tazim on 03/05/22.
//

import Foundation
import RxSwift

/* This is Currency usecase abstraction extented from AbstractUsecase. Which will be used to get currency related data from currency repository*/
protocol AbstractCurrencyUsecase: AbstractUsecase {
    func convert(fromAmount: String, fromCurrency: String, toCurrency: String) -> Observable<CurrencyApiRequest.ItemType>
}
