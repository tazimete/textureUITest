//
//  RepositoryHeaderParams.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/12/22.
//

import Foundation

struct RepositoryParams: Parameterizable {
    let clientId: String?
    let clientSecret: String?
    let authCode: String?
    let redirectUrl: String?
    let state: String?
    
    public init(clientId: String? = nil, clientSecret: String? = nil, authCode: String? = nil, redirectUrl: String? = nil, state: String? = nil) {
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.authCode = authCode
        self.redirectUrl = redirectUrl
        self.state = state
    }
    
    private enum CodingKeys: String, CodingKey {
        case clientId = "client_id"
        case clientSecret = "client_secret"
        case redirectUrl = "redirect_uri"
        case authCode = "code"
        case state
    }

    public var asRequestParam: [String: Any] {
        let param: [String: Any] = [CodingKeys.clientId.rawValue: clientId.unwrappedValue, CodingKeys.clientSecret.rawValue: clientSecret.unwrappedValue, CodingKeys.authCode.rawValue: authCode.unwrappedValue, CodingKeys.redirectUrl.rawValue: redirectUrl.unwrappedValue, CodingKeys.state.rawValue: state.unwrappedValue]
        return param.compactMapValues { $0 }
    }
}
