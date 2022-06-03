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
    
    @KVLocalStorage(key: "conversionCount", defaultValue: 0)
    var conversionCount: Int
    
    func setConversionCount(count: Int) {
        conversionCount = count
    }
    
    func getConversionCount() -> Int {
        return conversionCount
    }
}

