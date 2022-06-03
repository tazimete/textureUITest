//
//  AbstractDataModel.swift
//  currency-converter
//
//  Created by AGM Tazimon 5/8/21.
//

import Foundation


/*
 Base protocol for our server response
 */

protocol AbstractDataModel {
    var id: Int? {get set}
    
    //dictionary representation of this model 
    var asDictionary : [String: Any] {get}
    var asCellViewModel : AbstractCellViewModel {get}
}

