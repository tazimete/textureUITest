//
//  UserApiRequest.swift
//  currency-converter
//
//  Created by AGM Tazim on 03/05/22.
//

import Foundation

enum UserApiRequest {
    case getToken(params: Parameterizable)
}

extension UserApiRequest: APIRequest {
    public var baseURL: URL {
        return (AppConfig.shared.getServerConfig().getAuthCredential().tokenUrl)!
    }
    
    public typealias ItemType = UserAuth
    public typealias ResponseType = Response<ItemType>
    
    public var method: RequestType {
        switch self {
            case .getToken: return .GET
        }
    }
    
    public var path: String {
        switch self {
        case .getToken: return ""
        }
    }
    
    public var parameters: [String: Any]{
        var parameter: [String: Any] = [:]
        
        switch self {
            case .getToken (let params):
                parameter = params.asRequestParam
        }
        
        return parameter
    }
    
    public var headers: [String: Any] {
        return [String: Any]()
    }
}


