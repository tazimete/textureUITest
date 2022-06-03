//
//  GenericCell.swift
//  currency-converter
//
//  Created by AGM Tazimon 30/10/21.
//

import UIKit

protocol AbstractCellViewModel: AnyObject {
    var id: Int? {set get}
    var thumbnail: String? {set get}
    var title: String? {set get}
    var overview: String? {set get}
}

protocol ConfigurableCell {
    associatedtype DataType
    func configure(data: DataType)
}


protocol CellConfigurator {
    static var reuseId: String { get }
    func configure(cell: UIView)
}


// this class will be used to bind cellviewmodel to cell
class ListViewCellConfigurator<CellType: ConfigurableCell, DataType>: CellConfigurator where CellType.DataType == DataType, CellType: UIView {
    
    static var reuseId: String { return String(describing: CellType.self) }
    
    let item: DataType
    
    init(item: DataType) {
        self.item = item
    }
    
    func configure(cell: UIView) {
        (cell as! CellType).configure(data: item)
    }
}
