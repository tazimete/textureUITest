//
//  Abstraction.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/10/22.
//

import Foundation




/// This is the abstraction part of comission policy, will check balance precessing has commission or not
protocol ComissionApplicable {
    func hasComission(conversionSerial: Int, conversionAmount: Double) -> Bool
}


/// This is the abstraction part of commission policy, will be responsible for getting commission amount 
protocol ComissionAmount {
    var commissionOptions: ComissionDependency {get}
    
    init(commissionOptions: ComissionDependency)
    
    func getComissionAmount(conversionSerial: Int, conversionAmount: Double) -> Double
    func getComissionPercent(conversionSerial: Int, conversionAmount: Double) -> Double
}

typealias ComissionPolicy = ComissionApplicable & ComissionAmount
