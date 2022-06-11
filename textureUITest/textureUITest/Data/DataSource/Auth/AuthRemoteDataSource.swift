//
//  AuthRemoteDataSource.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/14/22.
//

import Foundation
import RxSwift

class AuthRemoteDataSource: AbstractAuthRemoteDataSource {
    let apiClient: AbstractApiClient
    
    init(apiClient: AbstractApiClient) {
        self.apiClient = apiClient
    }
    
    func getToken(authCode: String) -> Observable<UserApiRequest.ItemType> {
        return apiClient.send(apiRequest: UserApiRequest.convert(params: UserAuthParams(authCode: authCode)), type: UserApiRequest.ItemType.self)
    }
}
