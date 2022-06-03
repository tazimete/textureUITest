//
//  ComissionDependency.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/10/22.
//

import Foundation
import UIKit

class ComissionDependency {
    static let shared = ComissionDependency(comissionAmountInPercent: 0.7)
    
    public let comissionAmountInPercent: Double
    
    private init(comissionAmountInPercent: Double) {
        self.comissionAmountInPercent = comissionAmountInPercent
    }
}
