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
    let data: T?
    
    init(data: T? = nil, totalCount:Int? = nil) {
        self.totalCount = totalCount
        self.data = data
    }
    
    enum CodingKeys: String, CodingKey {
        case data = "items"
        case totalCount = "total_count"
    }
}
