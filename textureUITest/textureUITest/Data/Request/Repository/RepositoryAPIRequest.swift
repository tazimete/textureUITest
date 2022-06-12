//
//  RepositoryAPIRequest.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/12/22.
//

import Foundation

enum RepositoryAPIRequest {
    case search(params: Parameterizable)
}

extension RepositoryAPIRequest: APIRequest {
    var baseURL: URL {
        let url =  AppConfig.shared.getServerConfig().getBaseUrl()
        return URL(string: url)!
    }
    
    typealias ItemType = Repository
    typealias ResponseType = Response<[ItemType]>
    
    var method: RequestType {
        switch self {
            case .search: return .GET
        }
    }
    
    var path: String {
        switch self {
            case .search: return "/search/repositories"
        }
    }
    
    var parameters: [String: Any]{
        var parameter: [String: Any] = [:]
        
        switch self {
            case .search (let params):
                parameter = params.asRequestParam
        }
        
        return parameter
    }
    
    var headers: [String: Any] {
        var headers: [String: Any] = [:]
        
        switch self {
            case .search (let hParams):
            headers = hParams.asRequestParam
        }
        
        return headers
    }
}


