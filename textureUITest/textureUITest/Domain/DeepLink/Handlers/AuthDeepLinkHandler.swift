//
//  AuthDeepLinkHandler.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/11/22.
//

import UIKit

final class AuthDeepLinkHandler: DeeplinkHandlerProtocol {
    
    private weak var rootViewController: BaseViewController?
    init(rootViewController: BaseViewController?) {
        self.rootViewController = rootViewController
    }
    
    // MARK: - DeeplinkHandlerProtocol
    
    func canOpenURL(_ url: URL) -> Bool {
        return url.absoluteString.hasPrefix(DeepLinkScheme.OAuth.rawValue)
    }
    
    func openURL(_ url: URL) {
        guard canOpenURL(url) else {
            return
        }
        
        let vc = rootViewController as? AuthViewController
        vc?.receivedAuthCallback(url: url)
    }
}
