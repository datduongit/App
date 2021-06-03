//
//  URLResponse.swift
//  Networking
//
//  Created by ChungTV on 03/06/2021.
//

import Foundation

extension HTTPURLResponse {

    var status: HTTPStatusCode? {
        return HTTPStatusCode(rawValue: statusCode)
    }
    var responseError: HttpResponseError? {
        return HttpResponseError(rawValue: statusCode)
    }

}

extension URLResponse {
    var statusCode: HTTPStatusCode? {
        return (self as? HTTPURLResponse)?.status
    }

    var error: HttpResponseError? {
        return (self as? HTTPURLResponse)?.responseError
    }

}
