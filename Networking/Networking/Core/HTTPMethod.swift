//
//  HTTPMethod.swift
//  Networking
//
//  Created by ChungTV on 03/06/2021.
//

import Foundation

public enum HTTPMethod: String {
    case get        = "GET"
    case put        = "PUT"
    case post       = "POST"
    case patch      = "PATCH"
    case delete     = "DELETE"
    case head       = "HEAD"
    case options    = "OPTIONS"
    case trace      = "TRACE"
    case connect    = "CONNECT"
}
