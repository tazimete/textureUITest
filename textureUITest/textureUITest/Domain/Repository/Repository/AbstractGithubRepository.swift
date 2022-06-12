//
//  GithubRemoteRepository.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/12/22.
//

import Foundation
import RxSwift

/* This is repository repository abstraction extented from AbstractRepository. Which will be used to get user repository related data from api client/server response*/
protocol AbstractGithubRepository: AbstractRepository {
    func searchRemote(accessToken: String, page: Int) -> Observable<RepositoryAPIRequest.ResponseType>
    func searchLocal(accessToken: String, page: Int) -> Observable<[RepositoryAPIRequest.ItemType]>
}
