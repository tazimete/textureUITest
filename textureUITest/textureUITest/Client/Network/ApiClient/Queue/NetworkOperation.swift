//
//  NetworkOperation.swift
//  currency-converter
//
//  Created by AGM Tazimon 25/7/21.
//

import Foundation
import UIKit

class NetworkOperation: Operation {
    
    private var task: URLSessionTask?
    
    enum OperationState: Int {
        case ready
        case executing
        case finished
    }
    
    // default state is ready (when the operation is created)
    private var state : OperationState = .ready {
        willSet {
            self.willChangeValue(forKey: "isExecuting")
            self.willChangeValue(forKey: "isFinished")
        }
        
        didSet {
            self.didChangeValue(forKey: "isExecuting")
            self.didChangeValue(forKey: "isFinished")
        }
    }
    
    override public var isReady: Bool { return state == .ready }
    override public var isExecuting: Bool { return state == .executing }
    override public var isFinished: Bool { return state == .finished }
    
    public override init() {
        super.init()
    }
    
    public init<T: Codable>(apiRequest: APIRequest, type: T.Type, completionHandler: @escaping (NetworkCompletionHandler<T>)){
        super.init()
    
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil

        let session = URLSession(configuration: config)
        let request = apiRequest.request(with: apiRequest.baseURL)

        task = session.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    completionHandler(.failure(.serverError(code: (response as? HTTPURLResponse)?.statusCode ?? 101, message: "Request failed")))
                     self?.state = .finished
                     return
                }

                guard let mime = response.mimeType, mime == "application/json" else {
                    completionHandler(.failure(.wrongMimeTypeError(code: response.statusCode, message: "Wrong mimetype")))
                     self?.state = .finished
                     return
                }

                guard let responseData = data else{
                     completionHandler(.failure(.noDataError(code: response.statusCode, message: "No data found in response")))
                     self?.state = .finished
                     return
                }
                 
                 let resultData = try? JSONDecoder().decode(T.self, from: responseData)
                
                 if let result = resultData{
                     completionHandler(.success(result))
                 }else{
                     completionHandler(.failure(.decodingError(code: response.statusCode, message: "Decoding error, Wrong response type")))
                 }
                
                 self?.state = .finished
            }
       }
    }
    
    public init(session: URLSession, downloadTaskURL: URL, completionHandler: @escaping DownloadResultHandler) {
           super.init()
        
        let imageUrlString = downloadTaskURL.absoluteString
                
        AppLogger.debug("Downloading --  \(imageUrlString)")
        
        task = session.dataTask(with: downloadTaskURL) { [weak self] (data, response, error) in
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
                self?.state = .finished
            }
        }
    }
    
    override public func start() {
        if(self.isCancelled) {
            state = .finished
            return
        }
        
        // set the state to executing
        state = .executing
        
        AppLogger.debug("Processing \(self.task?.originalRequest?.url?.absoluteString ?? "")")
            
        // start the downloading
        self.task?.resume()
    }
    
    override public func cancel() {
        super.cancel()
        self.task?.cancel()
    }
}

