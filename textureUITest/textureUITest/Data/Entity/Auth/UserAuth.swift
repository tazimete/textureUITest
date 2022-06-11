//
//  UserAuth.swift
//  currency-converter
//
//  Created by AGM Tazimon 31/10/21.
//

import Foundation

/* UserAuth entity of Data layer */
struct UserAuth: Codable, Equatable {
    let accessToken: String?
    
    init(accessToken: String? = nil) {
        self.accessToken = accessToken 
    }
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
    
    static func ==(lhs: UserAuth, rhs: UserAuth) -> Bool {
        return lhs.accessToken.unwrappedValue == rhs.accessToken.unwrappedValue
    }
}


extension Optional where Wrapped == UserAuth {
    var unwrappedValue: UserAuth {
        return self ?? UserAuth()
    }
}
