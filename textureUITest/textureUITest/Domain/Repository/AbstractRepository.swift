//
//  AbstractRepository.swift
//  currency-converter
//
//  Created by AGM Tazim on 30/10/21.
//

import Foundation

/* Base repository abstraction will be used to make all other repository of this project, It will have apiClient to get data from server */
protocol AbstractRepository: AnyObject {
    var localDataSource: AbstractLocalDataSource {get}
    var remoteDataSource: AbstractRemoteDataSource {get}
}
