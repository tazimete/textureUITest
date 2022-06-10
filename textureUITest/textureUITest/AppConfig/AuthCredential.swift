//
//  AuthCredential.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/11/22.
//

import Foundation

class AuthCredential{
    var redirectUri = URL(string: "it.iacopo.github://authentication")!
    var authorizationUrl = URL(string: "https://github.com/login/oauth/authorize")!
    var tokenUrl = URL(string: "https://github.com/login/oauth/access_token")!
    var clientId = "fd2d97030f7ca8dfe654"
    var clientSecret = "c8d121ae90c1f70a5dfdbf37c083b6fe11a4ddb1"
    var scopes = ["repo", "user"]

    func addRedirectUri(uri: URL) {
        self.redirectUri = uri
    }
    
    func addAuthorizationUrl(url: URL) {
        self.authorizationUrl = url
    }
    
    func addTokenUrl(url: URL) {
        self.tokenUrl = url
    }
    
    func addClientId(client: String) {
        self.clientId = client
    }
    
    func addClientSecret(clientSecret: String) {
        self.clientSecret = clientSecret
    }
    
    func addPermissionScopes(scopes: [String]) {
        self.scopes = scopes
    }
}
