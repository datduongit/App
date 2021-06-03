//
//  URLRequest.swift
//  Networking
//
//  Created by ChungTV on 03/06/2021.
//

import Foundation

public extension URLRequest {
    
    var method: HTTPMethod? {
        get {
            guard let httpMethod = self.httpMethod else { return nil }
            return HTTPMethod(rawValue: httpMethod)
        }
        set {
            httpMethod = newValue?.rawValue
        }
    }
}
