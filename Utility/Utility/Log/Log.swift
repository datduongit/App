//
//  Log.swift
//  Utility
//
//  Created by Nguyen Duy Khanh on 04/02/2021.
//

import Foundation

/// Represents the Log facilities
public final class Log {
    
    public enum Level: Int {
        case debug = 0
        case info
        case error
        case none
    }
    
    public static var minLevel = Log.Level.none
    
    public class func debug(_ message: Any,
                            _ file: String = #file,
                            _ function: String = #function,
                            line: Int = #line) {
        log(level: .debug, "DEBUG: \(message)", file, function, line: line)
    }
    
    public class func info(_ message: Any,
                           _ file: String = #file,
                           _ function: String = #function,
                           line: Int = #line) {
        log(level: .info, "INFO: \(message)", file, function, line: line)
    }
    
    public class func error(_ message: Any,
                            _ file: String = #file,
                            _ function: String = #function,
                            line: Int = #line) {
        log(level: .error, "ERROR: \(message)", file, function, line: line)
    }
    
    private class func log(level: Log.Level,
                           _ message: Any,
                           _ file: String,
                           _ function: String,
                           line: Int) {
        let shouldLevelBeLogged = level.rawValue >= Log.minLevel.rawValue
        if shouldLevelBeLogged {
            let fname = (file as NSString).lastPathComponent
            print("\(fname):\(line)-\(message)")
        }
    }
    
}

