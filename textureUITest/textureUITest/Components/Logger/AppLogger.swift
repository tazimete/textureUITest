//
//  AppLogger.swift
//  currency-converter
//
//  Created by AGM Tazim on 03/05/22.
//

import Foundation


struct AppLogger {
    /// Prints an error message in debug only
    static func error(_ msg: Any, line: Int = #line, fileName: String = #file, funcName: String = #function) {
        console("ERROR: \(msg)", line: line, fileName: fileName, funcName: funcName)
    }
    
    /// Prints the debug info for the line
    static func debug(_ msg: Any, line: Int = #line, fileName: String = #file, funcName: String = #function) {
        console("DEBUG: \(msg)", line: line, fileName: fileName, funcName: funcName)
    }
    
    /// Prints the info for the line
    static func info(_ msg: Any, line: Int = #line, fileName: String = #file, funcName: String = #function) {
        console("INFO: \(msg)", line: line, fileName: fileName, funcName: funcName)
    }
    
    /// Prints the verbose for the line
    static func versbose(_ msg: Any, line: Int = #line, fileName: String = #file, funcName: String = #function) {
        console("VERBOSE: \(msg)", line: line, fileName: fileName, funcName: funcName)
    }
    
    /// Prints in debug only
    static func console(_ msg: Any, line: Int = #line, fileName: String = #file, funcName: String = #function) {
        #if DEBUG
            let fname = (fileName as NSString).lastPathComponent
            print("[\(fname) \(funcName):\(line)]", msg)
        #endif
    }
}
