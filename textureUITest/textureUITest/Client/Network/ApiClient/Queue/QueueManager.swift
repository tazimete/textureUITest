//
//  QueueManager.swift
//  currency-converter
//
//  Created by AGM Tazimon 25/7/21.
//

import Foundation

public class QueueManager {
    public static let shared = QueueManager()

    public lazy var queue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    public init(){
        
    }

    public func enqueue(_ operation: Operation) {
        queue.addOperation(operation)
    }
    
    public func getOperation(at index: Int) -> Operation {
       return queue.operations[index]
    }
}
