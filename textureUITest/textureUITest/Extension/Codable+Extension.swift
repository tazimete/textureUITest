//
//  Codable+Extension.swift
//  currency-converter
//
//  Created by AGM Tazimon 13/8/21.
//

import Foundation

extension Encodable {

    var asDictionary : [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any] else { return nil }
        return json
    }
}


extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
