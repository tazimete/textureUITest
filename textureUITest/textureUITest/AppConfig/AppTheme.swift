//
//  AppTheme.swift
//  currency-converter
//
//  Created by AGM Tazimon 1/11/21.
//

import Foundation


public class AppTheme {
    private var builder: Builder

    init(builder: Builder) {
        self.builder = builder
    }

    public func getColors() -> Colors{
        return self.builder.colors
    }

    public func getFonts(colors: Colors) -> Fonts{
        return self.builder.fonts
    }
    
    public class Builder{
        var colors: Colors!
        var fonts: Fonts!
        //        var style: style!
        
        public func addColors(colors: Colors) -> Builder{
            self.colors = colors
            return self
        }

        public func addFonts(fonts: Fonts) -> Builder{
            self.fonts = fonts
            return self
        }
        
        public func build() -> AppTheme {
            return AppTheme(builder: self)
        }
    }
}
