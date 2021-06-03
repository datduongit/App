//
//  FileHandlerOutputStream.swift
//  Logger
//
//  Created by ChungTV on 03/06/2021.
//

import Foundation

public class FileHandlerOutputStream: TextOutputStream {
    
    private let fileHandle: FileHandle
    public let filePath: URL

    public init(_ filePath: URL) throws {
        self.fileHandle = try FileHandle(forWritingTo: filePath)
        self.filePath = filePath
    }

    public func write(_ string: String) {
        if let data = string.data(using: .utf8) {
            fileHandle.write(data)
            if let newLine = "\n".data(using: .utf8) {
                fileHandle.write(newLine)
            }
        }
    }
}

public extension FileHandlerOutputStream {
    func truncate() {
        fileHandle.truncateFile(atOffset: 0)
    }
    
    func synchronize() {
        fileHandle.synchronizeFile()
    }
    
    func seekToEnd() {
        fileHandle.seekToEndOfFile()
    }
    
    func close() {
        fileHandle.closeFile()
    }
}
