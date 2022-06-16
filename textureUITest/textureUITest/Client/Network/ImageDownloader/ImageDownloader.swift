//
//  ImageDownloader.swift
//  currency-converter
//
//  Created by AGM Tazimon 17/8/21.
//

import UIKit


public class ImageDownloader: Downloader<UIImage> {
    static let shared = ImageDownloader()

    override init() {
        super.init()
    }
}
