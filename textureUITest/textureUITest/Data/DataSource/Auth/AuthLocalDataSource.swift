//
//  AuthLocalDataSource.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/14/22.
//

import Foundation
import RxSwift

class AuthLocalDataSource: AbstractAuthLocalDataSource {
    let dbClient: AbstractDatabaseClient
    
    init(dbClient: AbstractDatabaseClient) {
        self.dbClient = dbClient
    }
    
    func getToken(authCode: String) -> Observable<UserApiRequest.ItemType> {
        return dbClient.read(id: authCode, type: UserApiRequest.ItemType.self) 
    }
}
