//
//  ComissionExecutor.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/10/22.
//

import Foundation

struct ComissionCalculator {
    let commissionOptions: ComissionDependency
    let policies: [ComissionPolicy]
    
    init(commissionOptions: ComissionDependency, policies: [ComissionPolicy]) {
        self.commissionOptions = commissionOptions
        self.policies = policies
    }
    
    func hasCommission(conversionSerial: Int, conversionAmount: Double) -> (hasCommission: Bool, amount: Double, percent: Double) {
        var hasCommission = true
        var amount = 0.0
        var percent = 0.0
        
        for policy in policies {
            if !policy.hasComission(conversionSerial: conversionSerial, conversionAmount: conversionAmount) {
                hasCommission = false
                break
            } else {
                amount = policy.getComissionAmount(conversionSerial: conversionSerial, conversionAmount: conversionAmount)
                percent = policy.getComissionPercent(conversionSerial: conversionSerial, conversionAmount: conversionAmount)
            }
        }
        
        return (hasCommission: hasCommission, amount: amount, percent: percent)
    }
    
    func calculateCommissionAmount(conversionSerial: Int, conversionAmount: Double) -> Double {
        var amount = 0.0
        let result = hasCommission(conversionSerial: conversionSerial, conversionAmount: conversionAmount)
        if result.hasCommission {
            amount = result.amount
        }
        
        return amount
    }
    
    func calculateCommissionPercent(conversionSerial: Int, conversionAmount: Double) -> Double {
        var percent = 0.0
        let result = hasCommission(conversionSerial: conversionSerial, conversionAmount: conversionAmount)
        if result.hasCommission {
            percent = result.percent
        }
        
        return percent
    }
}
