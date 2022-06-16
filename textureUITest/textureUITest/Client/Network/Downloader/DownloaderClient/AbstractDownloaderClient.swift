//
//  AbstractDownloader.swift
//  currency-converter
//
//  Created by AGM Tazimon 14/8/21.
//

import UIKit


public typealias DownloadResultHandler = (Result<DownloaderResponse, NetworkError>) -> Void

public class DownloaderResponse {
    public var url: String?
    public var data: Data?
    public var isCached: Bool?
    
    init(url: String? = nil, data: Data? = nil, isCached: Bool? = nil) {
        self.url = url
        self.data = data
        self.isCached = isCached
    }
}


public protocol AbstractDownloaderClient: AnyObject {
    var queueManager: QueueManager {get set}
    func enqueue(session: URLSession, downloadTaskURL: URL, completionHandler: @escaping DownloadResultHandler)
    func download(session: URLSession, downloadTaskURL: URL, completionHandler: @escaping DownloadResultHandler)
}
