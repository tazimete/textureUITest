//
//  UserSessionData.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/7/22.
//

import Foundation


class UserSessionDataClient: AbstractUserSessionDataClient {
    public static let shared: AbstractUserSessionDataClient = UserSessionDataClient(kvContainer: UserDefaults.standard)
    public var kvContainer: AbstractLocalStorageIntereactor
    
    private init(kvContainer: AbstractLocalStorageIntereactor) {
        self.kvContainer = kvContainer
    }
    
    @KVLocalStorage(key: "accessToken", defaultValue: "")
    var accessToken: String
    
    func setAccessToken(token: String) {
        self.accessToken = token
    }
    
    func getAccessToken() -> String {
        return accessToken
    }
    
    @KVLocalStorage(key: "isAuthenticated", defaultValue: false)
    var isAuthenticated: Bool
    
    func setAuthenticated(authenticated: Bool) {
        self.isAuthenticated = authenticated
    }
    
    func getIsAuthenticated() -> Bool {
        return isAuthenticated
    }
}

