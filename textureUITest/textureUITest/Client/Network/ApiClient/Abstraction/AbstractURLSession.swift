//
//  URLSessionProtocol.swift
//  currency-converter
//
//  Created by AGM Tazimon 3/11/21.
//

import UIKit

typealias URLSessionDataTaskResult = (Data?, URLResponse?, Error?) -> Void

protocol AbstractURLSession: AnyObject {
    var responseType: Codable.Type? {get set}
    var defaultConfig: URLSessionConfiguration {get set}
    init(configuration: URLSessionConfiguration)
    func dataTask<T: Codable>(with request: URLRequest, type: T.Type ,completionHandler: @escaping URLSessionDataTaskResult) -> URLSessionDataTask
}

class URLSessionConfigHolder {
    static var config: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        
        return config
    }()
}

extension AbstractURLSession {
    var defaultConfig: URLSessionConfiguration {
        get {
            return URLSessionConfigHolder.config
        }set(newValue) {
            URLSessionConfigHolder.config  = newValue
        }
        
    }
}

extension URLSession: AbstractURLSession {
    var responseType: Codable.Type? {
        get {
            nil
        }
        set(newValue) {
            
        }
    }
    
    convenience init(config: URLSessionConfiguration = URLSessionConfigHolder.config) {
        self.init(configuration: config)
        defaultConfig = config
    }
    
    func dataTask<T>(with request: URLRequest, type: T.Type, completionHandler: @escaping URLSessionDataTaskResult) -> URLSessionDataTask where T : Decodable, T : Encodable {
        return self.dataTask(with: request, completionHandler: completionHandler)
    }
}

