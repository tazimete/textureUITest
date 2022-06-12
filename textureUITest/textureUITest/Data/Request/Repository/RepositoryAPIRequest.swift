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
    public var baseURL: URL {
        let url =  AppConfig.shared.getServerConfig().getBaseUrl()
        return URL(string: url)!
    }
    
    public typealias ItemType = Repository
    public typealias ResponseType = Response<[ItemType]>
    
    public var method: RequestType {
        switch self {
            case .search: return .GET
        }
    }
    
    public var path: String {
        switch self {
            case .search: return "/search/repositories"
        }
    }
    
    public var parameters: [String: Any]{
        var parameter: [String: Any] = [:]
        
        switch self {
            case .search (let params):
                parameter = params.asRequestParam
        }
        
        return parameter
    }
    
    public var headers: [String: Any] {
        var headers: [String: Any] = [:]
        
        switch self {
            case .search (let hParams):
            headers = hParams.asRequestParam
        }
        
        return headers
    }
}


