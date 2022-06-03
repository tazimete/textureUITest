//
//  AdaptiveLayoutExtension.swift
//  currency-converter
//
//  Created by AGM Tazim on 3/23/22.
//

import Foundation
import UIKit


extension UIStackView {
    
    open override func awakeFromNib() {
        if self.axis == .horizontal {
            self.spacing = self.spacing.relativeToIphone8Width()
        } else {
            self.spacing = self.spacing.relativeToIphone8Height()
        }
        self.layoutIfNeeded()
    }
    
    public convenience init(frame: CGRect, setAdaptive: Bool = true) {
        self.init(frame: frame)
        
        if self.axis == .horizontal {
            self.spacing = self.spacing.relativeToIphone8Width()
        } else {
            self.spacing = self.spacing.relativeToIphone8Height()
        }
        self.layoutIfNeeded()
    }
    
    public func applyAdaptiveLayout() {
        if self.axis == .horizontal {
            self.spacing = self.spacing.relativeToIphone8Width()
        } else {
            self.spacing = self.spacing.relativeToIphone8Height()
        }
        self.layoutIfNeeded()
    }
    
}

extension UILabel {
    
    open override func awakeFromNib() {
        self.font = self.font.withSize(self.font.pointSize.relativeToIphone8Width())
    }
    
    public convenience init(frame: CGRect, setAdaptive: Bool = true) {
        self.init(frame: frame)
        
        self.font = self.font.withSize(self.font.pointSize.relativeToIphone8Width())
    }
    
    public func applyAdaptiveLayout() {
        self.font = self.font.withSize(self.font.pointSize.relativeToIphone8Width())
    }
    
}

extension UITextView {
    
    open override func awakeFromNib() {
        self.font = self.font?.withSize((self.font?.pointSize.relativeToIphone8Width())!)
    }
    
    public convenience init(frame: CGRect, setAdaptive: Bool = true) {
        self.init(frame: frame)
        
        self.font = self.font?.withSize((self.font?.pointSize.relativeToIphone8Width())!)
    }
    
    public func applyAdaptiveLayout() {
        self.font = self.font?.withSize((self.font?.pointSize.relativeToIphone8Width())!)
    }
    
}

extension UITextField {
    
    open override func awakeFromNib() {
        self.font = self.font?.withSize((self.font?.pointSize.relativeToIphone8Width())!)
    }
    
    public convenience init(frame: CGRect, setAdaptive: Bool = true) {
        self.init(frame: frame)
        
        self.font = self.font?.withSize((self.font?.pointSize.relativeToIphone8Width())!)
    }
    
    public func applyAdaptiveLayout() {
        self.font = self.font?.withSize((self.font?.pointSize.relativeToIphone8Width())!)
    }
    
}

extension UIButton {
    
    open override func awakeFromNib() {
        self.titleLabel?.font = self.titleLabel?.font.withSize((self.titleLabel?.font.pointSize.relativeToIphone8Width())!)
    }
    
    public convenience init(frame: CGRect, setAdaptive: Bool = true) {
        self.init(frame: frame)
        
        self.titleLabel?.font = self.titleLabel?.font.withSize((self.titleLabel?.font.pointSize.relativeToIphone8Width())!)
    }
    
    public func applyAdaptiveLayout() {
        self.titleLabel?.font = self.titleLabel?.font.withSize((self.titleLabel?.font.pointSize.relativeToIphone8Width())!)
    }
}

