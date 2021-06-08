//
//  AppAPIEndpoint.swift
//  App
//
//  Created by ChungTV on 04/06/2021.
//

import Networking

enum AppApiEndpoint: APIEndpoint {
    case core
    case frontendLocal(host: String, port: Int?)
    
    var components: (host: String, basePath: String) {
        switch self {
        case .core:
            return (ApiConfig.BASE_URL, "/chungtv")
        case .frontendLocal(let host, _):
            return (host, "/chungtv")
        }
    }
    
    var port: Int? {
        switch self {
        case .frontendLocal(_, let port):
            return port
        default:
            return nil
        }
    }
    
    var scheme: String {
        switch self {
        case .frontendLocal:
            return "http"
        default:
            return "https"
        }
    }
}
