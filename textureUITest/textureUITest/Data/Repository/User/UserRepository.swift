//
//  UserRepository.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/12/22.
//

import Foundation
import RxSwift

/* This is user repository class implementation from AbstractUserRepository. Which will be used to get user related data from api client/server response*/
class UserRepository: AbstractUserRepository {
    let localDataSource: AbstractLocalDataSource
    let remoteDataSource: AbstractRemoteDataSource
    
    init(localDataSource: AbstractLocalDataSource, remoteDataSource: AbstractRemoteDataSource) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
 
    func searchRemote(accessToken: String, query: String, page: Int) -> Observable<UserAPIRequest.ResponseType> {
        return (remoteDataSource as! AbstractUserRemoteDataSource).search(accessToken: accessToken, query: query, page: page)
    }
    
    func searchLocal(accessToken: String, query: String, page: Int) -> Observable<[UserAPIRequest.ItemType]> {
        return (localDataSource as! AbstractUserLocalDataSource).search(accessToken: accessToken, query: query, page: page)
    }
    
    func getUserRemote(accessToken: String, name: String, id: Int) -> Observable<UserAPIRequest.ItemType> {
        return (remoteDataSource as! AbstractUserRemoteDataSource).getUser(accessToken: accessToken, name: name, id: id)
    }
    
    func getUserLocal(accessToken: String, name: String, id: Int) -> Observable<UserAPIRequest.ItemType> {
        return (localDataSource as! AbstractUserLocalDataSource).getUser(accessToken: accessToken, name: name, id: id)
    }
}
