//
//  RepositoryRemoteDataSource.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/12/22.
//

import Foundation
import RxSwift

class RepositoryRemoteDataSource: AbstractRepositoryRemoteDataSource {
    let apiClient: AbstractApiClient
    
    init(apiClient: AbstractApiClient) {
        self.apiClient = apiClient
    }
    
    func search(accessToken: String, page: Int) -> Observable<RepositoryAPIRequest.ResponseType> {
        return apiClient.send(apiRequest: RepositoryAPIRequest.search(params: RepositoryParams(query: "", page: page, perPage: 10, sort: "name", order: "asc")), type: RepositoryAPIRequest.ResponseType.self)
    }
}
