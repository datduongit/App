//
//  URLRequestBuilder.swift
//  Networking
//
//  Created by ChungTV on 03/06/2021.
//

import Foundation

class URLRequestBuilder {
    
    let endpoint: APIEndpoint
    
    
    init(endpoint: APIEndpoint) {
        self.endpoint = endpoint
    }
    
    private var method: HTTPMethod = .get
    
    private var path: String = ""
    private var timeoutInterval: TimeInterval = 30
    private var cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    private var httpHeader: [String: String]?
    private var parameters: ParametersType?
    private var sendingData: Encodable?
    private var encodingFactory: HTTPEncoding.Factory?
    private var multipartData: MultipartFormDataBuilderType?
    
    final func build() -> URLRequest {
        let url = generateUrlComponent(path: path, parameters: parameters)
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = timeoutInterval
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = httpHeader
        urlRequest.cachePolicy = cachePolicy
        if let multipart = multipartData {
            let body = multipart.build()
            urlRequest.httpBody = body
            urlRequest.setValue("multipart/form-data; boundary=\(multipart.boundary)", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("\(body.count)", forHTTPHeaderField: "Content-Length")
        } else if sendingData != nil {
            urlRequest.httpBody = sendingData?.toData(using: encodingFactory?.create())
        } else {
            urlRequest.httpBody = nil
        }
        return urlRequest
    }
    
    func path(_ path: String) -> URLRequestBuilder {
        self.path = path
        return self
    }
    
    func cachePolicy(_ policy: URLRequest.CachePolicy) -> URLRequestBuilder {
        self.cachePolicy = policy
        return self
    }
    
    func httpMethod(_ method: HTTPMethod) -> URLRequestBuilder {
        self.method = method
        return self
    }
    
    func httpHeaders(_ headers: [String: String]?) -> URLRequestBuilder {
        self.httpHeader = headers
        return self
    }
    
    func parameters(_ params: ParametersType?) -> URLRequestBuilder {
        self.parameters = params
        return self
    }
    
    func sendingData(_ data: Encodable? = nil,
                     _ encodingFactory: HTTPEncoding.Factory = HTTPEncoding.Factory(),
                     _ multipartData: MultipartFormDataBuilderType? = nil) -> URLRequestBuilder {
        self.sendingData = data
        if data != nil {
            self.encodingFactory = encodingFactory
        } else {
            self.encodingFactory = nil
        }
        self.multipartData = multipartData
        return self
    }
    
    func timeout(_ time: TimeInterval) -> URLRequestBuilder {
        self.timeoutInterval = time
        return self
    }
    
    private func generateUrlComponent(path: String, parameters: ParametersType?) -> URL {
        var components = URLComponents()
        
        let (host, basePath) = endpoint.components
        components.scheme = endpoint.scheme
        components.host = host
        components.port = endpoint.port
        components.path = basePath + path
        
        components.queryItems = parameters?.map { URLQueryItem(name: $0.key, value: "\($0.value)")}
        
        // Fix "+" sign is not encoded in query, so it becomes a space character
        components.percentEncodedQuery = components.percentEncodedQuery?
            .replacingOccurrences(of: "+", with: "%2B")
        
        return components.url!
    }
}


private extension Encodable {
    func toData(using encoder: JSONEncoder?) -> Data? {
        try? encoder?.encode(self)
    }
}
