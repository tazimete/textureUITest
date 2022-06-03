//
//  BalanceDependency.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/24/22.
//

import Foundation


class BalanceDependency {
    static let shared: BalanceDependency = BalanceDependency(totalEuro: 1000.00, totalUSD: 0.00, totalJPY: 0.00)
    let totalEuro: Double
    let totalUSD: Double
    let totalJPY: Double
    
    private init(totalEuro: Double, totalUSD: Double, totalJPY: Double) {
        self.totalEuro = totalEuro
        self.totalUSD = totalUSD
        self.totalJPY = totalJPY
    }
}
