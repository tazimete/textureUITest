//
//  User.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/18/22.
//

import Foundation


/* UserCredential entity of presentation layer */
struct UserCredential: Codable, Equatable {
    public let id: String?
    public let token: String?
    public let name: String?
    public let email: String?
    
    init(id: String? = nil, token: String? = nil, name: String? = nil, email: String? = nil) {
        self.id = id
        self.token = token
        self.name = name
        self.email = email
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case token = "token"
        case name = "name"
        case email = "email"
    }
    
    static func ==(lhs: UserCredential, rhs: UserCredential) -> Bool {
        return lhs.id.unwrappedValue == rhs.id.unwrappedValue && lhs.email.unwrappedValue == rhs.email.unwrappedValue
    }
}


extension Optional where Wrapped == UserCredential {
    var unwrappedValue: UserCredential {
        return self ?? UserCredential()
    }
}
