//
//  ImageDownloaderClient.swift
//  currency-converter
//
//  Created by AGM Tazimon 14/8/21.
//

import Foundation
import UIKit


public class DownloaderClient: AbstractDownloaderClient {
    public static let shared = DownloaderClient()
    public var queueManager: QueueManager

    
    public init(withQueueManager queueManager: QueueManager = QueueManager()) {
        self.queueManager = queueManager
    }
    
    public func enqueue(session: URLSession, downloadTaskURL: URL, completionHandler: @escaping DownloadResultHandler) {
        let operation = NetworkOperation(session: session, downloadTaskURL: downloadTaskURL, completionHandler: completionHandler)
        operation.qualityOfService = .utility
        queueManager.enqueue(operation)
    }
    
    public func download(session: URLSession, downloadTaskURL: URL, completionHandler: @escaping DownloadResultHandler) {
        let imageUrlString = downloadTaskURL.absoluteString
                
        session.dataTask(with: downloadTaskURL) { [weak self] (data, response, error) in
            if let _ = error {
                DispatchQueue.main.async {
                    completionHandler(.failure(.serverError(code: (response as? HTTPURLResponse)?.statusCode ?? 101, message: "Request failed")))
                }
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.noDataError(code: (response as? HTTPURLResponse)?.statusCode ?? 500, message: "Wrong mimetype")))
                return
            }
            
            // Always execute completion handler explicitly on main thread
            DispatchQueue.main.async {
                completionHandler(.success(.init(url: imageUrlString, data: data, isCached: false)))
            }
        }.resume()
    }
}
