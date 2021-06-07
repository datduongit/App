//
//  Repository.swift
//  Networking
//
//  Created by ChungTV on 03/06/2021.
//

import Foundation

open class APIService<T: HTTPClient> {
    
    public let client: T
    
    public required init(client: T) {
        self.client = client
    }
    
    @discardableResult
    public func dataTask<R: Encodable, T: Decodable>(_ method: HTTPMethod,
                                                     _ path: String,
                                                     _ headers: [String: String]? = nil,
                                                     _ params: ParametersType? = nil,
                                                     _ sendingData: R? = nil,
                                                     _ encoding: HTTPEncoding.Factory = HTTPEncoding.Factory(),
                                                     completion: ((Result<T, Error>) -> Void)?,
                                                     completionWithResponse: ((Result<T, Error>, URLResponse?) -> Void)? = nil) -> CancellableRequest? {
        guard let endpoint = getEndpoint() else {
            completion?(.failure(HttpRequestError.urlNil))
            return nil
        }
        let urlRequestBuilder = URLRequestBuilder(endpoint: endpoint)
            .path(path)
            .httpHeaders(getDefaultHeaders().joined(headers ?? [:]))
            .parameters(getDefaultParams().joined(params ?? [:]))
            .sendingData(sendingData, encoding)
        return client.dataTask(request: urlRequestBuilder.build(),
                               completion: completion,
                               completionWithResponse: completionWithResponse)
    }
    
    @discardableResult
    public func multipartDataTask<R: Decodable>(_ method: HTTPMethod,
                                                _ path: String,
                                                _ headers: [String: String]? = nil,
                                                _ params: ParametersType? = nil,
                                                _ multiparts: [MultipartFormDataType]? = nil,
                                                completion: ((Result<R, Error>) -> Void)?,
                                                completionWithResponse: ((Result<R, Error>, URLResponse?) -> Void)? = nil) -> CancellableRequest? {
        guard let endpoint = getEndpoint() else {
            completion?(.failure(HttpRequestError.urlNil))
            return nil
        }
        let urlRequestBuilder = URLRequestBuilder(endpoint: endpoint)
            .path(path)
            .httpHeaders(getDefaultHeaders().joined(headers ?? [:]))
            .parameters(getDefaultParams().joined(params ?? [:]))
        if let forms = multiparts, forms.isEmpty {
            let multipartBuilder = MultipartFormDataBuilder()
            forms.forEach { multipartBuilder.append($0) }
            urlRequestBuilder.multipartDataBuilder(multipartBuilder)
        }
        return client.dataTask(request: urlRequestBuilder.build(),
                               completion: completion,
                               completionWithResponse: completionWithResponse)
    }
    
    open func getEndpoint() -> APIEndpoint? {
        return nil
    }
    
    open func getDefaultHeaders() -> [String: String] {
        return [:]
    }
    
    open func getDefaultParams() -> ParametersType {
        return [:]
    }
}
