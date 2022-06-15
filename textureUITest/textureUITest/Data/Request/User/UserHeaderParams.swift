//
//  RepositoryHeaderParams.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/12/22.
//

import Foundation

struct UserHeaderParams: Parameterizable {
    let accept = "application/vnd.github.v3+json"
    let authorization: String
    
    public init(authorization: String) {
        self.authorization = authorization
    }
    
    private enum CodingKeys: String, CodingKey {
        case accept = "Accept"
        case authorization = "Authorization"
    }

    public var asRequestParam: [String: Any] {
        let param: [String: Any] = [CodingKeys.authorization.rawValue: "token " + authorization, CodingKeys.accept.rawValue: accept]
        return param.compactMapValues { $0 }
    }
}
