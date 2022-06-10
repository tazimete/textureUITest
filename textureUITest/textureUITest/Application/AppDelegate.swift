//
//  AppDelegate.swift
//  currency-converter
//
//  Created by AGM Tazim on 03/05/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: AuthCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //build app configuration
        buildAppConfig()
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
       
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

    
    private func buildAppConfig() -> Void {
        let themeColors = Colors(primaryDark: .systemBlue, primaryLight: .systemOrange, secondaryDark: .black, secondaryLight: .systemBlue, textColorDark: .black, textColorLight: .white, primaryBackgroundColor: .white, secondaryBackgroundColor: .blue, disabledTextColor: .lightGray, whiteTransparentColor: .init(white: 1, alpha: 0.5))
        
        let themeFonts = Fonts()
        
        let theme = AppTheme.Builder()
            .addColors(colors: themeColors)
            .addFonts(fonts: themeFonts)
            .build()

        let authConfig = AuthCredential(redirectUri: URL(string: "it.iacopo.github://authentication"), authorizationUrl: URL(string: "https://github.com/login/oauth/authorize"), tokenUrl: URL(string: "https://github.com/login/oauth/access_token"), clientId: "fd2d97030f7ca8dfe654", clientSecret: "c8d121ae90c1f70a5dfdbf37c083b6fe11a4ddb1", scopes: ["repo", "user"])
        
        //server/api config builder
        let serverConfig = ServerConfig.Builder()
            .addBaseUrl(baseUrl: "http://api.evp.lt")
            .addApiVersion(apiVersion: "3")
            .addAuthCredential(credential: authConfig)
            .addMediaBaseUrl(mediaBaseUrl: "")
            .addBuildType(buildType: .DEVELOP)
            .build()

        let deeplinkHandler = DeepLinkHandler()
        let deepLinkCallback: (DeepLink) -> Void = { deepLink in
            if case .oAuth(let url) = deepLink {
//                oAuthService.exchangeCodeForToken(url: url)
            }
        }
        deeplinkHandler.addCallback(deepLinkCallback, forDeepLink: DeepLink(url: authConfig.redirectUri!)!)
        
        //Singleton with builder, commit-> no return  
        AppConfig.Builder()
            .setServerConfig(serverConfig: serverConfig)
            .setThemeType(themeType: .NORMAL)
            .setNormalTheme(theme: theme)
            .setDarkTheme(theme: theme)
            .setLocale(local: "en")
            .setDeeplinkHandler(handler: deeplinkHandler)
            .commit()
    }

}

