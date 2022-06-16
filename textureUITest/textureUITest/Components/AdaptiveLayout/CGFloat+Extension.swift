//
//  CGFloat+Extension.swift
//  currency-converter
//
//  Created by AGM Tazim on 3/23/22.
//

import Foundation
import UIKit

let minScalableValue: CGFloat = 8.0 // Min value that should undergo upper scaling for bigger iphones and iPads

extension CGFloat {
    
    func adaptiveWidth(shouldUseLimit: Bool = true) -> CGFloat {
        let upperScaleLimit: CGFloat = 1.8
        var toUpdateValue = floor(self * (UIScreen.main.bounds.width / 375))
        
        guard self > minScalableValue else {return toUpdateValue}
        
        guard shouldUseLimit else {return toUpdateValue}
        
        guard upperScaleLimit > 1 else {return toUpdateValue}
        
        let limitedValue = self * upperScaleLimit
        
        if toUpdateValue > limitedValue {
            toUpdateValue = limitedValue
        }
        
        return toUpdateValue
    }
    
    
    func adaptiveHeight(shouldUseLimit: Bool = true) -> CGFloat {
        var extraHeight: CGFloat = 0
        
        if #available(iOS 11.0, *) {
            extraHeight = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            extraHeight = extraHeight + (UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 20) - 20
        }
        
        let upperScaleLimit: CGFloat = 1.8
        var toUpdateValue = floor(self * ((UIScreen.main.bounds.height - extraHeight) / 667))
        
        guard self > minScalableValue else {return toUpdateValue}
        
        guard shouldUseLimit else {return toUpdateValue}
        
        guard upperScaleLimit > 1 else {return toUpdateValue}
        
        let limitedValue = self * upperScaleLimit
        
        if toUpdateValue > limitedValue {
            toUpdateValue = limitedValue
        }
        
        return toUpdateValue
    }
    
}
