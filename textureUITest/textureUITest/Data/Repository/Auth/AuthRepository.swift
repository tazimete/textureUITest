//
//  AuthRepository.swift
//  currency-converter
//
//  Created by AGM Tazim on 30/10/21.
//

import Foundation
import RxSwift

/* This is auth repository class implementation from AbstractAuthRepository. Which will be used to get user auth related data from api client/server response*/
class AuthRepository: AbstractAuthRepository {
    let localDataSource: AbstractLocalDataSource
    let remoteDataSource: AbstractRemoteDataSource
    
    init(localDataSource: AbstractLocalDataSource, remoteDataSource: AbstractRemoteDataSource) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
    
    func getToken(authCode: String) -> Observable<UserApiRequest.ItemType> {
        return (remoteDataSource as! AbstractAuthRemoteDataSource).getToken(authCode: authCode)
    }
}
