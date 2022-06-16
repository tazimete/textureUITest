//
//  User.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/12/22.
//

import Foundation

/* User entity of Data layer */
struct User: Codable, Equatable {
    let id: Int?
    let name: String?
    let email: String?
    let description: String?
    let avatarUrl: String?
    let type: String?
    
    init(id: Int? = nil, name: String? = nil, email:String? = nil,  description: String? = nil, avatarUrl: String? = nil, type: String? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.description = description
        self.avatarUrl = avatarUrl
        self.type = type
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "login"
        case email = "email"
        case description = "bio"
        case avatarUrl = "avatar_url"
        case type = "type"
    }
    
    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.id.unwrappedValue == rhs.id.unwrappedValue && lhs.name.unwrappedValue == rhs.name.unwrappedValue
    }
}


extension Optional where Wrapped == User {
    var unwrappedValue: User {
        return self ?? User()
    }
}
