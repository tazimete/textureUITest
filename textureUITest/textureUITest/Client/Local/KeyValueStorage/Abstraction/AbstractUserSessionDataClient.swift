//
//  AbstractUserSessionDataClient.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/11/22.
//

import Foundation


protocol AbstractUserSessionDataClient {
    static var shared: AbstractUserSessionDataClient {get}
    var kvContainer: AbstractLocalStorageIntereactor {get}
    
    var accessToken: String {get}
    func setAccessToken(token: String)
    func getAccessToken() -> String
    
    var isAuthenticated: Bool {get}
    func setAuthenticated(authenticated: Bool)
    func getIsAuthenticated() -> Bool
}
