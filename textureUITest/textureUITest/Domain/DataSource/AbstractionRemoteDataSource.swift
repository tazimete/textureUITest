//
//  AbstractionDataSource.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/13/22.
//

import Foundation


/* This base remote datasource of all remote datasource will be used in this project. It will have a base api client to get data from server. */
protocol AbstractRemoteDataSource: AnyObject {
    var apiClient: AbstractApiClient {get}
}
