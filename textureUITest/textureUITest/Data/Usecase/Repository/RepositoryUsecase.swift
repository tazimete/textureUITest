//
//  RepositoryUsecase.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/12/22.
//

import Foundation
import RxSwift

/* This is repository usecase class implentation from AbstractRepositoryUsecase. Which will be used to get user repo related data from userRepo repository*/
class RepositoryUsecase: AbstractRepositoryUsecase {
    let repository: AbstractRepository
    
    init(repository: AbstractUserRepoRepository) {
        self.repository = repository
    }
    
    func search(accessToken: String, page: Int) -> Observable<RepositoryAPIRequest.ResponseType> {
        (repository as! AbstractUserRepoRepository).searchRemote(accessToken: accessToken, page: page)
    }
}
