//
//  UserAuthParams.swift
//  currency-converter
//
//  Created by AGM Tazimon 24/7/21.
//

import Foundation


struct UserAuthParams: Parameterizable {
    let authCode: String

    public init(authCode: String) {
        self.authCode = authCode
    }

    public enum CodingKeys: String, CodingKey {
        case authCode = "authCode"
    }

    public var asRequestParam: [String: Any] {
        let param: [String: Any] = [CodingKeys.authCode.rawValue: authCode]
        return param.compactMapValues { $0 }
    }
}
