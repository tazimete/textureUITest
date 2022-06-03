//
//  AbstractLocalDataSource.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/13/22.
//

import Foundation


/* This base local datasource of all local datasource will be used in this project. It will have a base databse client to get data from local databse. */
protocol AbstractLocalDataSource: AnyObject {
    var dbClient: AbstractDatabaseClient {get}
}

