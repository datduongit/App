//
//  AppHTTPClient.swift
//  App
//
//  Created by ChungTV on 07/06/2021.
//

import Foundation
import Networking

class AppHTTPClient: HTTPClient {
    let token: String
    init(token: String, config: URLSessionConfiguration) {
        self.token = token
        let session = URLSession(configuration: config)
        super.init(session: session)
    }
}
