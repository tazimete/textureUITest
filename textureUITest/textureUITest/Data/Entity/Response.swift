//
//  Response.swift
//  currency-converter
//
//  Created by AGM Tazimon 31/10/21.
//

import Foundation

/* Wrapper response of  api, which has array of dynamic  content like - currency */
public struct Response<T: Codable>: Codable {
    public let result: T?
    
    public init(result: T? = nil) {
        self.result = result
    }
    
    public enum CodingKeys: String, CodingKey {
        case result = "result"
    }
}
