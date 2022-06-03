//
//  AbstractImageDownloader.swift
//  currency-converter
//
//  Created by AGM Tazimon 15/8/21.
//

import UIKit

public typealias DownloadCompletionHandler<T> = (String, T?, Bool) -> Void

public protocol AbstractDownloader: AnyObject {
    associatedtype T
    
    var downloaderClient: AbstractDownloaderClient {set get}
    var serialQueueForData: DispatchQueue {set get}
    var serialQueueForDataTasks: DispatchQueue {set get}
    var cachedDataList: [String: T] {set get}
    var dataDownloadSessionList: [String: URLSession] {set get}
    
    func download(with urlString: String?, completionHandler: @escaping (DownloadCompletionHandler<T>), placeholder: T?)
    func getCachedDataFrom(urlString: String) -> T?
    func getDataTaskFrom(urlString: String) -> URLSession?
}
