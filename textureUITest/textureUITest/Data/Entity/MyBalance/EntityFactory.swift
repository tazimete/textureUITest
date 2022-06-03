//
//  BalanceFactory.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/21/22.
//

import Foundation
import UIKit

protocol AbstractEntityFactory {
    associatedtype ModelType
    
    func createList(type: ModelType) -> [AbstractDataModel]
}

class EntityFactory: AbstractEntityFactory {
    enum ModelType{
        case balance
        case currencyExchange
    }
    
    func createList(type: ModelType) -> [AbstractDataModel] {
        var result = [AbstractDataModel] ()
        let dependency = BalanceDependency.shared
        
        if type == .balance {
            result =  [Balance(amount: dependency.totalEuro, currency: "EUR"), Balance(amount: dependency.totalUSD, currency: "USD"), Balance(amount: dependency.totalJPY, currency: "JPY")]
        }
        
        return result
    }
}

