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
        let authConfig = AppConfig.shared.getServerConfig().getAuthCredential()
        
        return apiClient.send(apiRequest: UserApiRequest.convert(params: UserAuthParams(clientId: authConfig.clientId, clientSecret: authConfig.clientSecret, authCode: authCode, redirectUrl: authConfig.redirectUri?.absoluteString, state: "")), type: UserApiRequest.ItemType.self)
    }
}
