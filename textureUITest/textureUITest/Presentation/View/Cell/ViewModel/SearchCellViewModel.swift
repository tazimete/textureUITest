//
//  SearchCellViewModel.swift
//  currency-converter
//
//  Created by AGM Tazimon 4/11/21.
//

import Foundation


class CurrencyCellViewModel: AbstractCellViewModel {
    var id: Int?
    var thumbnail: String?
    var title: String?
    var overview: String?
    
    init(id: Int? = nil, thumbnail: String? = nil, title: String? = nil, overview: String? = nil) {
        self.id = id
        self.thumbnail = thumbnail
        self.title = title
        self.overview = overview
    }
}

