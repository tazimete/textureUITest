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

public class AuthCredential{
    public var token: String?
    public var apiKey: String?

    public init() {

    }

    public init(token: String?) {
        self.token = token
    }
    
    public init(apiKey: String?) {
        self.apiKey = apiKey
    }
}

public class ServerConfig {
    private var builder: Builder

    private init(builder: Builder) {
        self.builder = builder
    }

    public func getBaseUrl() -> String{
        return self.builder.baseUrl
    }
    
    public func getMediaBaseUrl() -> String{
        return self.builder.mediaBaseUrl
    }

    public func getApiVersion() -> String{
        return self.builder.apiVersion
    }

    public func setAuthCredential() -> AuthCredential{
        return self.builder.credential
    }

    public class Builder{
        var baseUrl: String!
        var apiVersion: String!
        var mediaBaseUrl: String!
        var buildType: BuildType!
        var credential: AuthCredential!

        public func addBaseUrl(baseUrl: String) -> Builder{
            self.baseUrl = baseUrl
            return self
        }

        public func addApiVersion(apiVersion: String) -> Builder{
            self.apiVersion = apiVersion
            return self
        }

        public func addAuthCredential(credential: AuthCredential) -> Builder{
            self.credential = credential
            return  self
        }

        public func addBuildType(buildType: BuildType) -> Builder{
            self.buildType = buildType
            return  self
        }
        
        public func addMediaBaseUrl(mediaBaseUrl: String) -> Builder{
            self.mediaBaseUrl = mediaBaseUrl
            return self
        }

        public func build() -> ServerConfig {
            return ServerConfig(builder: self)
        }
    }
}
