//
//  UserAuth.swift
//  currency-converter
//
//  Created by AGM Tazimon 31/10/21.
//

import Foundation

/* UserAuth entity of Data layer */
struct UserAuth: Codable, Equatable {
    var id: String?
    var token: String?
    var email: String?
    
    init(id: String? = nil, token: String? = nil, email: String? = nil) {
        self.id = id
        self.token = token
        self.email = email
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case token = "token"
        case email = "email"
    }
    
    static func ==(lhs: UserAuth, rhs: UserAuth) -> Bool {
        return lhs.id.unwrappedValue == rhs.id.unwrappedValue && lhs.email.unwrappedValue == rhs.email.unwrappedValue
    }
}


extension Optional where Wrapped == UserAuth {
    var unwrappedValue: UserAuth {
        return self ?? UserAuth()
    }
}
