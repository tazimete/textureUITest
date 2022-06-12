//
//  Repository.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/12/22.
//

import Foundation

/* UserAuth entity of Data layer */
struct Repository: Codable, Equatable {
    let id: String?
    let name: String?
    let description: String?
    
    init(id: String? = nil, name: String? = nil, description: String? = nil) {
        self.id = id
        self.name = name
        self.description = description
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
    }
    
    static func ==(lhs: Repository, rhs: Repository) -> Bool {
        return lhs.id.unwrappedValue == rhs.id.unwrappedValue && lhs.name.unwrappedValue == rhs.name.unwrappedValue
    }
}


extension Optional where Wrapped == Repository {
    var unwrappedValue: Repository {
        return self ?? Repository()
    }
}
