//
//  AbstractUsecase.swift
//  currency-converter
//
//  Created by AGM Tazimon 30/10/21.
//

import Foundation


/* This base usecase of all usecase will be used in this project. It will have a base repository to get data from api client. */
protocol AbstractUsecase: AnyObject {
    var repository: AbstractRepository {get}
}
