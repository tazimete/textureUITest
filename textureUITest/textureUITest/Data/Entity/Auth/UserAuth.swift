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
    let tokenType: String?
    
    init(accessToken: String? = nil, tokenType: String? = nil) {
        self.accessToken = accessToken
        self.tokenType = tokenType
    }
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
    }
    
    static func ==(lhs: UserAuth, rhs: UserAuth) -> Bool {
        return lhs.accessToken.unwrappedValue == rhs.accessToken.unwrappedValue && lhs.tokenType.unwrappedValue == rhs.tokenType.unwrappedValue
    }
}


extension Optional where Wrapped == UserAuth {
    var unwrappedValue: UserAuth {
        return self ?? UserAuth()
    }
}
