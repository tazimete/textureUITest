//
//  AppConfig.swift
//  currency-converter
//
//  Created by AGM Tazimon 1/11/21.
//

import Foundation
import UIKit


public class AppConfig {
    public static let shared = AppConfig()
    private var builder: Builder!

    private init() {
    }

    private init(builder: Builder) {
        self.builder = builder
    }

    public func getServerConfig() -> ServerConfig {
        return self.builder.serverConfig
    }

    public func getLocal() -> String {
        return self.builder.local
    }

    public func getTheme() -> AppTheme {
        return self.builder.theme
    }

    public func getThemeType() -> ThemeType {
        return self.builder.themeType
    }

    public func getBuildType() -> BuildType {
        return self.builder.buildType
    }


    public class Builder{
        var local: String!
        var serverConfig: ServerConfig!
        var theme: AppTheme!
        var themeType: ThemeType!
        var buildType: BuildType!

        public func setServerConfig(serverConfig: ServerConfig) -> Builder{
            self.serverConfig = serverConfig
            return self
        }

        public func setThemeType(themeType: ThemeType) -> Builder{
            self.themeType = themeType
            return self
        }

        public func addBuildType(buildType: BuildType) -> Builder{
            self.buildType = buildType
            return  self
        }

        public func setNormalTheme(theme: AppTheme) -> Builder{
            self.theme = theme
            return self
        }

        public func setDarkTheme(theme: AppTheme) -> Builder{
            self.theme = theme
            return self
        }

        public func setLocale(local: String) -> Builder{
            self.local = local
            return self
        }

        public func commit() {
            AppConfig.shared.builder = self
        }
    }
}
