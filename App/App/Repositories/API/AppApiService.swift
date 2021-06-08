//
//  AppAPIService.swift
//  App
//
//  Created by ChungTV on 04/06/2021.
//

import Networking

class AppApiService: APIService<AppHttpClient> {
    override func getEndpoint() -> APIEndpoint? {
        return AppApiEndpoint.core
    }
    
    override func getDefaultParams() -> ParametersType {
        return ["platform": "iOS",
                "locale": "vi"]
    }
    
    override func getDefaultHeaders() -> [String : String] {
        return [ApiConfig.HEADER_CONTENT_TYPE: ApiConfig.HEADER_CONTENT_TYPE_JSON,
                "Token": client.token]
    }
}
