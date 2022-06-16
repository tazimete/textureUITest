//
//  DownloadDataParser.swift
//  currency-converter
//
//  Created by AGM Tazimon 17/8/21.
//

import UIKit


public class DownloadDataParser<T> {
    public static func getObjectAsType(data: Data) -> T? {
        var output: T?
        
        if T.self is UIImage.Type  {
            output = UIImage(data: data)?.decodedImage() as? T
        }

        return output
    }
}
