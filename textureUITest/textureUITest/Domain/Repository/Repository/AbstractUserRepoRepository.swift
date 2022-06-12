//
//  GithubRemoteRepository.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/12/22.
//

import Foundation
import RxSwift

/* This is user repo repository abstraction extented from AbstractRepository. Which will be used to get user repository related data from api client/server response*/
protocol AbstractUserRepoRepository: AbstractRepository {
    func searchRemote(accessToken: String, page: Int) -> Observable<RepositoryAPIRequest.ResponseType>
    func searchLocal(accessToken: String, page: Int) -> Observable<[RepositoryAPIRequest.ItemType]>
}
