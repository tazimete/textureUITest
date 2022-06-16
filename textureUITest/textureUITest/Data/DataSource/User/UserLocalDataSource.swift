//
//  UserLocalDataSource.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/12/22.
//

import Foundation
import RxSwift

class UserLocalDataSource: AbstractUserLocalDataSource {
    
    let dbClient: AbstractDatabaseClient
    
    init(dbClient: AbstractDatabaseClient) {
        self.dbClient = dbClient
    }
    
    func search(accessToken: String, query: String, page: Int) -> Observable<[UserAPIRequest.ItemType]> {
        return dbClient.readAll(type: UserAPIRequest.ItemType.self)
    }
    
    func getUser(accessToken: String, name: String, id: Int) -> Observable<UserAPIRequest.ItemType> {
        return dbClient.read(id: String(id), type: UserAPIRequest.ItemType.self)
    }
}
