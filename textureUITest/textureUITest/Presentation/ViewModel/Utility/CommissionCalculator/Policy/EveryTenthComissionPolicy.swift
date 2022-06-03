//
//  EveryTenthComissionPolicy.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/10/22.
//

import Foundation


struct EveryTenthComissionPolicy: ComissionPolicy {
    private(set) var commissionOptions: ComissionDependency
    
    init(commissionOptions: ComissionDependency) {
        self.commissionOptions = commissionOptions
    }
    
    func hasComission(conversionSerial: Int, conversionAmount: Double) -> Bool {
        if (conversionSerial % 10) == 0 {
            return false
        }
        
        return true
    }
    
    func getComissionAmount(conversionSerial: Int, conversionAmount: Double) -> Double {
        var amount = 0.0
        
        if hasComission(conversionSerial: conversionSerial, conversionAmount: conversionAmount) {
            amount = (conversionAmount * commissionOptions.comissionAmountInPercent)/100
        }
        
        return amount
    }
    
    func getComissionPercent(conversionSerial: Int, conversionAmount: Double) -> Double {
        var percent = 0.0
        
        if hasComission(conversionSerial: conversionSerial, conversionAmount: conversionAmount) {
            percent = commissionOptions.comissionAmountInPercent
        }
        
        return percent
    }
}
