//
//  ServerConfig.swift
//  currency-converter
//
//  Created by AGM Tazimon 1/11/21.
//

import Foundation


public enum BuildType {
    case DEVELOP
    case PRODUCTION
    case STAGING
}

class ServerConfig {
    private var builder: Builder

    private init(builder: Builder) {
        self.builder = builder
    }

    func getBaseUrl() -> String{
        return self.builder.baseUrl
    }
    
    func getMediaBaseUrl() -> String{
        return self.builder.mediaBaseUrl
    }

    func getApiVersion() -> String{
        return self.builder.apiVersion
    }

    func getAuthCredential() -> AuthCredential{
        return self.builder.credential
    }

    class Builder{
        var baseUrl: String!
        var apiVersion: String!
        var mediaBaseUrl: String!
        var buildType: BuildType!
        var credential: AuthCredential!

        func addBaseUrl(baseUrl: String) -> Builder{
            self.baseUrl = baseUrl
            return self
        }

        func addApiVersion(apiVersion: String) -> Builder{
            self.apiVersion = apiVersion
            return self
        }

        func addAuthCredential(credential: AuthCredential) -> Builder{
            self.credential = credential
            return  self
        }

        func addBuildType(buildType: BuildType) -> Builder{
            self.buildType = buildType
            return  self
        }
        
        func addMediaBaseUrl(mediaBaseUrl: String) -> Builder{
            self.mediaBaseUrl = mediaBaseUrl
            return self
        }

        func build() -> ServerConfig {
            return ServerConfig(builder: self)
        }
    }
}
