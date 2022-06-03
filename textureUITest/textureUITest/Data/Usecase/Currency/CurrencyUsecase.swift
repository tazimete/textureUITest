//
//  CurrencyUsecase.swift
//  currency-converter
//
//  Created by AGM Tazim on 14/05/22.
//

import Foundation
import RxSwift

/* This is Currency usecase class implentation from AbstractCurrencyUsecase. Which will be used to get currency related data from currency repository*/
class CurrencyUsecase: AbstractCurrencyUsecase {
    let repository: AbstractRepository
    
    public init(repository: AbstractCurrencyRepository) {
        self.repository = repository
    }
    
    func convert(fromAmount: String, fromCurrency: String, toCurrency: String) -> Observable<CurrencyApiRequest.ItemType> {
        return (repository as! AbstractCurrencyRepository).get(fromAmount: fromAmount, fromCurrency: fromCurrency, toCurrency: toCurrency)
    }
}
