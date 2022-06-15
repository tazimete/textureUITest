//
//  RepositoryAPIRequest.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/12/22.
//

import Foundation

enum UserAPIRequest {
    case search(params: Parameterizable, headers: Parameterizable)
    case getUserDetails(params: Parameterizable, headers: Parameterizable)
}

extension UserAPIRequest: APIRequest {
    var baseURL: URL {
        let url =  AppConfig.shared.getServerConfig().getBaseUrl()
        return URL(string: url)!
    }
    
    typealias ItemType = Repository
    typealias ResponseType = Response<[ItemType]>
    typealias ResponseTypeDetails = Response<ItemType>
    
    var method: RequestType {
        switch self {
            case .search: return .GET
            case .getUserDetails: return .GET
        }
    }
    
    var path: String {
        switch self {
            case .search: return "/search/users"
            case .getUserDetails: return "/search/users"
        }
    }
    
    var parameters: [String: Any]{
        var parameter: [String: Any] = [:]
        
        switch self {
            case .search(let params, _):
                parameter = params.asRequestParam
            case .getUserDetails(let params, _):
                parameter = params.asRequestParam
        }
        
        return parameter
    }
    
    var headers: [String: Any] {
        var headers: [String: Any] = [:]
        
        switch self {
            case .search(_, let hParams):
                headers = hParams.asRequestParam
            case .getUserDetails(_, let hParams):
                headers = hParams.asRequestParam
        }
        
        return headers
    }
}


