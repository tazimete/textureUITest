//
//  UserRemoteDataSource.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/12/22.
//

import Foundation
import RxSwift

class UserRemoteDataSource: AbstractUserRemoteDataSource {
    let apiClient: AbstractApiClient
    
    init(apiClient: AbstractApiClient) {
        self.apiClient = apiClient
    }
    
    func search(accessToken: String, query: String, page: Int) -> Observable<UserAPIRequest.ResponseType> {
        return apiClient.send(apiRequest: UserAPIRequest.search(params: UserSearchRequestParams(query: query, page: page, perPage: 10, sort: "followers", order: "asc"), headers: UserHeaderParams(authorization: accessToken)), type: UserAPIRequest.ResponseType.self)
    }
    
    func getUser(accessToken: String, name: String, id: Int) -> Observable<UserAPIRequest.ResponseTypeDetails> {
        return apiClient.send(apiRequest: UserAPIRequest.getUserDetails(params: UserDetailsParams(id: id, name: name), headers: UserHeaderParams(authorization: accessToken)), type: UserAPIRequest.ResponseTypeDetails.self)
    }
}
