//
//  Abstractions.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/11/22.
//

import Foundation


protocol DeeplinkHandlerProtocol {
    func canOpenURL(_ url: URL) -> Bool
    func openURL(_ url: URL)
}


protocol DeeplinkCoordinatorProtocol {
    @discardableResult
    func handleURL(_ url: URL) -> Bool
}
