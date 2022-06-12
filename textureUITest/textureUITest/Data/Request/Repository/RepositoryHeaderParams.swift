//
//  RepositoryHeaderParams.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/12/22.
//

import Foundation

struct RepositoryHeaderParams: Parameterizable {
    let authorization: String
    
    public init(authorization: String) {
        self.authorization = authorization
    }
    
    private enum CodingKeys: String, CodingKey {
        case authorization = "Authorization"
    }

    public var asRequestParam: [String: Any] {
        let param: [String: Any] = [CodingKeys.authorization.rawValue: authorization]
        return param.compactMapValues { $0 }
    }
}
