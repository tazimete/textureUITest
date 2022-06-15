//
//  UserDetailsParams.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/16/22.
//

import Foundation

struct UserDetailsParams: Parameterizable {
    let id: Int?
    let name: String?
    
    public init(id: Int? = nil, name: String? = nil) {
        self.id = id
        self.name = name
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }

    public var asRequestParam: [String: Any] {
        let param: [String: Any] = [CodingKeys.id.rawValue: id.unwrappedValue, CodingKeys.name.rawValue: name.unwrappedValue]
        return param.compactMapValues { $0 }
    }
}
