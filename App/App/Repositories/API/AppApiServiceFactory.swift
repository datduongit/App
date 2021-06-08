//
//  AppApiServiceFactory.swift
//  App
//
//  Created by ChungTV on 04/06/2021.
//

import Networking

class AppApiServiceFactory {
    private static let CONFIG_CORE_MOBILE = "CONFIG_CORE_MOBILE"
    
    private static let instance = AppApiServiceFactory()
    
    private var builderDict: [String: BuilderInfo] = [:]
    
    static func create<T: AppApiService>(_ service: T.Type) -> T {
        let token = "" // Get token from database
        let client: AppHttpClient
        if let builderInfo = instance.builderDict[CONFIG_CORE_MOBILE],
           builderInfo.valid(token) {
            client = AppHttpClient(token: token, config: builderInfo.config)
        } else {
            let config = URLSessionConfiguration.default
            // Increase number of simultaneous API requests
            config.httpMaximumConnectionsPerHost = 15
            config.timeoutIntervalForRequest = 60
            config.timeoutIntervalForResource = 60
            config.httpShouldSetCookies = false
            
            var builderInfo = BuilderInfo(config: config)
            builderInfo.token = token
            instance.builderDict[CONFIG_CORE_MOBILE] = builderInfo
            client = AppHttpClient(token: token, config: builderInfo.config)
        }
        return T(client: client)
    }
    
    private struct BuilderInfo {
        let config: URLSessionConfiguration
        var token: String?
       
        func valid(_ token: String?) -> Bool {
            guard let _token = token else {
                return false
            }
            return self.token == _token
        }
    }
}
