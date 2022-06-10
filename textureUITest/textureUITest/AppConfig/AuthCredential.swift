//
//  AuthCredential.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/11/22.
//

import Foundation

class AuthCredential{
    let redirectUri: URL?
    let authorizationUrl: URL?
    let tokenUrl: URL?
    let clientId: String?
    let clientSecret: String?
    let scopes: [String]?
    
    init(redirectUri: URL? = nil, authorizationUrl: URL? = nil, tokenUrl: URL? = nil, clientId: String? = nil, clientSecret: String? = nil, scopes: [String]? = nil) {
        self.redirectUri = redirectUri
        self.authorizationUrl = authorizationUrl
        self.tokenUrl = tokenUrl
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.scopes = scopes
    }
}
