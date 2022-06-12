//
//  UserRepoRepository.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/12/22.
//

import Foundation
import RxSwift

/* This is userrepo repository class implementation from AbstractUserRepoRepository. Which will be used to get user repo related data from api client/server response*/
class UserRepoRepository: AbstractUserRepoRepository {
    let localDataSource: AbstractLocalDataSource
    let remoteDataSource: AbstractRemoteDataSource
    
    init(localDataSource: AbstractLocalDataSource, remoteDataSource: AbstractRemoteDataSource) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
 
    func searchRemote(accessToken: String, page: Int) -> Observable<RepositoryAPIRequest.ResponseType> {
        return (remoteDataSource as! AbstractRepositoryRemoteDataSource).search(accessToken: accessToken, page: page)
    }
    
    func searchLocal(accessToken: String, page: Int) -> Observable<[RepositoryAPIRequest.ItemType]> {
        return (localDataSource as! AbstractRepositoryLocalDataSource).search(accessToken: accessToken, page: page)
    }
}
