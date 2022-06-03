//
//  ConfigComponents.swift
//  currency-converter
//
//  Created by AGM Tazimon 1/11/21.
//

import UIKit

public enum ThemeType{
    case NORMAL
    case DARK
}

// theme color collection
public class Colors {
    public var primaryDark: UIColor?
    public var primaryLight: UIColor?
    public var secondaryDark: UIColor?
    public var secondaryLight: UIColor?
    public var textColorDark: UIColor?
    public var textColorLight: UIColor?
    public var primaryBackgroundColor: UIColor?
    public var secondaryBackgroundColor: UIColor?
    public var disabledTextColor: UIColor?
    public var whiteTransparentColor: UIColor?
    
    init(primaryDark: UIColor? = nil, primaryLight: UIColor? = nil, secondaryDark: UIColor? = nil, secondaryLight: UIColor? = nil, textColorDark: UIColor? = nil, textColorLight: UIColor? = nil, primaryBackgroundColor: UIColor? = nil, secondaryBackgroundColor: UIColor? = nil, disabledTextColor: UIColor? = nil, whiteTransparentColor: UIColor? = nil) {
        self.primaryDark = primaryDark
        self.primaryLight = primaryLight
        self.secondaryDark = secondaryDark
        self.secondaryLight = secondaryLight
        self.textColorDark = textColorDark
        self.textColorLight = textColorLight
        self.primaryBackgroundColor = primaryBackgroundColor
        self.secondaryBackgroundColor = secondaryBackgroundColor
        self.disabledTextColor = disabledTextColor
        self.whiteTransparentColor = whiteTransparentColor
    }
}

// fonts collection
public class Fonts {
    public var primaryNormal: UIFont?
    public var primaryBold: UIFont?
    public var primarySemibold: UIFont?
    
    init(primaryNormal: UIFont? = nil, primaryBold: UIFont? = nil, primarySemibold: UIFont? = nil) {
        self.primaryNormal = primaryNormal
        self.primaryBold = primaryBold
        self.primarySemibold = primarySemibold
    }
}
