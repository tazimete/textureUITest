//
//  RepositoryUsecase.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/12/22.
//

import Foundation
import RxSwift

/* This is user usecase class implentation from AbstractUserUsecase. Which will be used to get user  related data from user repository*/
class UserUsecase: AbstractUserUsecase {
    let repository: AbstractRepository
    
    init(repository: AbstractUserRepository) {
        self.repository = repository
    }
    
    func search(accessToken: String, query: String, page: Int) -> Observable<UserAPIRequest.ResponseType> {
        return (repository as! AbstractUserRepository).searchRemote(accessToken: accessToken, query: query, page: page)
    }
    
    func getUserDetails(accessToken: String, name: String, id: Int) -> Observable<UserAPIRequest.ItemType> {
        return (repository as! AbstractUserRepository).getUserRemote(accessToken: accessToken, name: name, id: id)
    }
}
