//
//  RepositoryParams.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/12/22.
//

import Foundation

struct RepositoryParams: Parameterizable {
    let query: String?
    let page: Int?
    let perPage: Int?
    let sort: String?
    let order: String?
    
    public init(query: String? = nil, page: Int? = nil, perPage: Int? = nil, sort: String? = nil, order: String? = nil) {
        self.query = query
        self.page = page
        self.perPage = perPage
        self.sort = sort
        self.order = order
    }
    
    private enum CodingKeys: String, CodingKey {
        case query = "q"
        case page = "page"
        case perPage = "per_page"
        case sort = "sort"
        case order = "order"
    }

    public var asRequestParam: [String: Any] {
        let param: [String: Any] = [CodingKeys.query.rawValue: query.unwrappedValue, CodingKeys.page.rawValue: page.unwrappedValue, CodingKeys.perPage.rawValue: perPage.unwrappedValue, CodingKeys.sort.rawValue: sort.unwrappedValue, CodingKeys.order.rawValue: order.unwrappedValue]
        return param.compactMapValues { $0 }
    }
}
