//
//  CancellableRequest.swift
//  Networking
//
//  Created by ChungTV on 03/06/2021.
//

import Foundation

public protocol CancellableRequest {
    func cancel()
}

// A request that do nothing
public class EmptyRequest: CancellableRequest {
    public func cancel() {
        // do nothing
    }
}

extension URLSessionTask: CancellableRequest {}
