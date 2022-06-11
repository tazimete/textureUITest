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

    func getServerConfig() -> ServerConfig {
        return builder.serverConfig
    }

    func getLocal() -> String {
        return builder.local
    }

    func getTheme() -> AppTheme {
        return builder.theme
    }

    func getThemeType() -> ThemeType {
        return builder.themeType
    }

    func getBuildType() -> BuildType {
        return builder.buildType
    }
    
    func getDeepLinkCoordinator() -> DeeplinkCoordinator {
        return builder.deepLinkCoordinator
    }
    
    func setDeepLinkCoordinator(coordinator: DeeplinkCoordinator) {
        builder.deepLinkCoordinator = coordinator
    }


    class Builder{
        var local: String!
        var serverConfig: ServerConfig!
        var theme: AppTheme!
        var themeType: ThemeType!
        var buildType: BuildType!
        var deepLinkCoordinator: DeeplinkCoordinator!

        func setServerConfig(serverConfig: ServerConfig) -> Builder{
            self.serverConfig = serverConfig
            return self
        }

        func setThemeType(themeType: ThemeType) -> Builder{
            self.themeType = themeType
            return self
        }

        func setBuildType(buildType: BuildType) -> Builder{
            self.buildType = buildType
            return  self
        }

        func setNormalTheme(theme: AppTheme) -> Builder{
            self.theme = theme
            return self
        }

        func setDarkTheme(theme: AppTheme) -> Builder{
            self.theme = theme
            return self
        }

        func setLocale(local: String) -> Builder{
            self.local = local
            return self
        }
        
        func setDeepLinkCoordinator(coordinator: DeeplinkCoordinator) -> Builder{
            self.deepLinkCoordinator = coordinator
            return self
        }

        func commit() {
            AppConfig.shared.builder = self
        }
    }
}
