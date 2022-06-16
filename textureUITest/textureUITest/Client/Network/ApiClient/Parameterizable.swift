//
//  Parameterizable.swift
//  currency-converter
//
//  Created by AGM Tazimon 24/7/21.
//

import Foundation


public protocol Parameterizable {
    var asRequestParam: [String: Any] { get }
}

