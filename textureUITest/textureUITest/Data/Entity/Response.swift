//
//  Response.swift
//  currency-converter
//
//  Created by AGM Tazimon 31/10/21.
//

import Foundation

/* Wrapper response of  api, which has array of dynamic  content like - repository */
struct Response<T: Codable>: Codable {
    let totalCount: Int?
    let items: T?
    
    init(items: T? = nil, totalCount:Int? = nil) {
        self.totalCount = totalCount
        self.items = items
    }
    
    enum CodingKeys: String, CodingKey {
        case items = "items"
        case totalCount = "total_count"
    }
}
