//
//  Repository.swift
//  Networking
//
//  Created by ChungTV on 03/06/2021.
//

import Foundation

class CustomerRequestBuilder: URLRequestBuilder {
    
}

class APIService {
    
    let client: HTTPClient
    
    
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func dataTask<R: Encodable>(_ method: HTTPMethod,
                                _ path: String,
                                _ headers: [String: String]? = nil,
                                _ params: ParametersType? = nil,
                                _ sendingData: R?,
                                _ encoding: HTTPEncoding.Factory = HTTPEncoding.Factory()) -> CancellableRequest? {
        guard let endpoint = getEndpoint() else {
            return nil
        }
        let urlRequest = URLRequestBuilder(endpoint: endpoint)
            .path(path)
            .httpHeaders(defaultHeaders().joined(headers ?? [:]))
            .parameters(defaultParams().joined(params ?? [:]))
            .sendingData(sendingData, encoding).build()
//        client.dataTask(request: urlRequest, completion: <#T##((Result<Decodable, Error>) -> Void)?##((Result<Decodable, Error>) -> Void)?##(Result<Decodable, Error>) -> Void#>)
        return nil
    }
    
    func getEndpoint() -> APIEndpoint? {
        return nil
    }
    
    func defaultHeaders() -> [String: String] {
        return [:]
    }
    
    func defaultParams() -> ParametersType {
        return [:]
    }
}
