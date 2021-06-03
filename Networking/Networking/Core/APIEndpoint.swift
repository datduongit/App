//
//  APIEndpoint.swift
//  Networking
//
//  Created by ChungTV on 03/06/2021.
//

import Foundation

public protocol APIEndpoint {
    var scheme: String { get }
    var components: (host: String, basePath: String) { get }
    var port: Int? { get }
}
