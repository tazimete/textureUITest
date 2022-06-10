//
//  DeepLinkHelper.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/10/22.
//

import Foundation

let scheme = "it.iacopo.github"

enum DeepLink: Hashable {
    enum DeepLinkScheme: String {
        case OAuth = "it.iacopo.github://authentication"
    }
    
    case oAuth(URL)
    
    init?(url: URL) {
        switch url.absoluteString.components(separatedBy: "?")[0] {
            case DeepLinkScheme.OAuth.rawValue :
                self = .oAuth(url)
            default:
                return nil
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .oAuth:
            return hasher.combine(1)
        }
    }
    
    static func ==(lhs: DeepLink, rhs: DeepLink) -> Bool {
      return lhs.hashValue == rhs.hashValue
    }
}

class DeepLinkHandler {
    typealias DeeplinkCallback = (DeepLink) -> Void
    
    var callbackMap: [DeepLink: DeeplinkCallback] = [:]
    
    func addCallback(_ callback: @escaping DeeplinkCallback, forDeepLink deepLink: DeepLink) {
        callbackMap[deepLink] = callback
    }
    
    func handleDeepLinkIfPossible(deepLink: DeepLink) {
        guard let callback = callbackMap[deepLink] else { return  }
        
        callback(deepLink)
    }
}
