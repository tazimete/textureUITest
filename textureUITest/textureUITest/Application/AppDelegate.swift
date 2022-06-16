//
//  AppDelegate.swift
//  currency-converter
//
//  Created by AGM Tazim on 03/05/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow? {
        return (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window
    }
    
    var rootViewController: UIViewController? {
        return (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.rootViewController
    }
    
    var rootCoordinator: AuthCoordinator? {
        return (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.rootCoordinator
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //make app config
        buildAppConfig()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
       // Not Implemented Yet 
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func buildAppConfig() -> Void {
        let themeColors = Colors(primaryDark: .systemBlue, primaryLight: .systemOrange, secondaryDark: .black, secondaryLight: .systemBlue, textColorDark: .black, textColorLight: .white, primaryBackgroundColor: .white, secondaryBackgroundColor: .blue, disabledTextColor: .lightGray, whiteTransparentColor: .init(white: 1, alpha: 0.5))
        
        let themeFonts = Fonts()
        
        let theme = AppTheme.Builder()
            .addColors(colors: themeColors)
            .addFonts(fonts: themeFonts)
            .build()

        let authConfig = AuthCredential(redirectUri: URL(string: "it.iacopo.github://authentication"), authorizationUrl: URL(string: "https://github.com/login/oauth/authorize"), tokenUrl: URL(string: "https://github.com/login/oauth/access_token"), clientId: "fd2d97030f7ca8dfe654", clientSecret: "c8d121ae90c1f70a5dfdbf37c083b6fe11a4ddb1", scopes: ["repo", "user"])
        
        //server/api config builder
        let serverConfig = ServerConfig.Builder()
            .addBaseUrl(baseUrl: "https://api.github.com")
            .addApiVersion(apiVersion: "")
            .addAuthCredential(credential: authConfig)
            .addMediaBaseUrl(mediaBaseUrl: "")
            .addBuildType(buildType: .DEVELOP)
            .build()
        
        //Singleton with builder, commit-> no return
        AppConfig.Builder()
            .setServerConfig(serverConfig: serverConfig)
            .setThemeType(themeType: .NORMAL)
            .setNormalTheme(theme: theme)
            .setDarkTheme(theme: theme)
            .setLocale(local: "en")
            .commit()
    }

}

