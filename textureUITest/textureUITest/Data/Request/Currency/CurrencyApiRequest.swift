//
//  Network.swift
//  currency-converter
//
//  Created by AGM Tazim on 03/05/22.
//

import Foundation

enum CurrencyApiRequest {
    case convert(params: Parameterizable)
}

extension CurrencyApiRequest: APIRequest {
    public var baseURL: URL {
        let url =  "\(AppConfig.shared.getServerConfig().getBaseUrl())"
        return URL(string: url)!
    }
    
    public typealias ItemType = Currency
    public typealias ResponseType = Response<ItemType>
    
    public var method: RequestType {
        switch self {
            case .convert: return .GET
        }
    }
    
    public var path: String {
        switch self {
        case .convert: return "/currency/commercial/exchange/\(parameters[CurrencyConverterParams.CodingKeys.fromAmount.rawValue] ?? "")-\(parameters[CurrencyConverterParams.CodingKeys.fromCurrency.rawValue] ?? "")/\(parameters[CurrencyConverterParams.CodingKeys.toCurrency.rawValue] ?? "")/latest"
        }
    }
    
    public var parameters: [String: Any]{
        var parameter: [String: Any] = [:]
        
        switch self {
            case .convert (let params):
                parameter = params.asRequestParam
        }
        
        return parameter
    }
    
    public var headers: [String: String] {
        return [String: String]()
    }
}


