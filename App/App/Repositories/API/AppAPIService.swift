//
//  AppAPIService.swift
//  App
//
//  Created by ChungTV on 04/06/2021.
//

import Networking

class AppAPIService: APIService {
    override func getEndpoint() -> APIEndpoint? {
        return AppAPIEndpoint.core
    }
    
    override func getDefaultParams() -> ParametersType {
        return ["platform": "iOS",
                "locale": "vi"]
    }
    
    override func getDefaultHeaders() -> [String : String] {
        return [APIConfig.HEADER_CONTENT_TYPE: APIConfig.HEADER_CONTENT_TYPE_JSON]
    }
}
