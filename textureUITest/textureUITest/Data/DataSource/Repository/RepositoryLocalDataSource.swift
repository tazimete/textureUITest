//
//  RepositoryLocalDataSource.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/12/22.
//

import Foundation
import RxSwift

class RepositoryLocalDataSource: AbstractRepositoryLocalDataSource {
    
    let dbClient: AbstractDatabaseClient
    
    init(dbClient: AbstractDatabaseClient) {
        self.dbClient = dbClient
    }
    
    func search(accessToken: String, page: Int) -> Observable<[RepositoryAPIRequest.ItemType]> {
        return dbClient.readAll(type: RepositoryAPIRequest.ItemType.self)
    }
}
