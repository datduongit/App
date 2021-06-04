//
//  HTTPClient.swift
//  Networking
//
//  Created by ChungTV on 03/06/2021.
//

import Foundation
import Logger

private let TAG = "[HTTPClient]"
private let responseTimeWarningThreshold: Double = 1500 // ms

public class HTTPClient {
    
    private let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    public var enableGETLogs: Bool = false

    /// Create a dataTask for URLRequest
    /// This function will respect `request.httpBody`, if request has its own body then the parameter `body` will not be set.
    /// - Parameters: request
    /// - Parameters: body
    ///
    @discardableResult
    func dataTask<R>(request: URLRequest,
                     completion: ((Result<R, Error>) -> Void)?,
                     completionWithResponse: ((Result<R, Error>, URLResponse?) -> Void)? = nil,
                     function: String = #function) -> CancellableRequest where R: Decodable {
        let requestUrl = request.url?.absoluteString ?? ""
        
        Log.network.d(category: .network, TAG, "Method:", request.httpMethod ?? "UNKNOWN", "-", requestUrl)
        Log.network.d(category: .network, TAG, "Headers:", request.allHTTPHeaderFields ?? [:])
        
        if let body = request.httpBody {
            Log.network.d(category: .network, TAG, "Body:", String(data: body, encoding: .utf8) ?? "")
        }
        
        let startTime: DispatchTime? = Log.network.isEnabled ? .now() : nil
        
        let task = session.dataTask(with: request) { (data, response, error) in
            self.handleDataTask(request: request,
                                method: HTTPMethod(rawValue: request.httpMethod ?? ""),
                                data: data,
                                response: response,
                                error: error,
                                completion: completion,
                                completionWithResponse: completionWithResponse,
                                function: function,
                                startTime: startTime)
        }
        
        task.resume()
        return task
    }

    private func handleDataTask<R>(request: URLRequest,
                                   method: HTTPMethod?,
                                   data: Data?,
                                   response: URLResponse?,
                                   error: Error?,
                                   completion: ((Result<R, Error>) -> Void)?,
                                   completionWithResponse: ((Result<R, Error>, URLResponse?) -> Void)?,
                                   function: String = #function,
                                   startTime: DispatchTime? = nil) where R: Decodable {
        
        func onComplete(_ result: Result<R, Error>) {
            DispatchQueue.main.async {
                if let compl = completion {
                    compl(result)
                } else if let compl = completionWithResponse {
                    compl(result, response)
                }
            }
        }
        
        let requestUrl = request.url?.absoluteString ?? ""
        
        if let start = startTime {
            let duration = Double(DispatchTime.now().uptimeNanoseconds - start.uptimeNanoseconds) / 1_000_000
            Log.network.d(category: .network, TAG, "Response time:", duration > responseTimeWarningThreshold ? "⚠️" : "",
                  "\(round(duration)) ms", "-", requestUrl)
        }
        
        if let error = error {
            if let nsError = error as NSError?, nsError.code == URLError.Code.cancelled.rawValue {
                Log.network.d(category: .network, TAG, "Cancelled: ", requestUrl)
                return
            }

            onComplete(.failure(error))
            Log.network.e(category: .network, TAG, requestUrl, error)
            return
        }

        guard let statusCode = (response as? HTTPURLResponse)?.status else {
            onComplete(.failure(HttpResponseError.noStatusCode))
            Log.network.e(category: .network, TAG, requestUrl, String(describing: response))
            return
        }

        guard let receivedData = data else {
            onComplete(.failure(HttpResponseError.noReturnData))
            Log.network.e(category: .network, TAG, requestUrl, "- noReturnData")
            return
        }
        
        if method != .get || enableGETLogs, let responseBody = String(data: receivedData, encoding: .utf8) {
            Log.network.d(category: .network, TAG, "Response body:", responseBody)
        }
        
        func handleTextPlainResponse() -> Bool {
            guard let response = response as? HTTPURLResponse else {
                return false
            }
            
            guard let contentType = response.allHeaderFields[ApiConsts.contentTypeHeaderKey] as? String,
                  contentType.starts(with: ApiConsts.contentTypeTextPlain) else {
                return false
            }
            
            if let string = String(data: receivedData, encoding: .utf8) as? R {
                onComplete(.success(string))
                return true
            }
            
            return false
        }

        switch statusCode.responseType {
        case .informational:
            break
            
        case .success:

            if let empty = EmptyResponse() as? R {
                onComplete(.success(empty))
                return
            }

            do {
                let decoder = HTTPDecoding.Factory().create()
                if let type = R.self as? UseCustomKeyDecodingStrategyType.Type {
                    decoder.keyDecodingStrategy = type.keyDecodingStrategy
                }
                let parsedObject = try decoder.decode(R.self, from: receivedData)
                onComplete(.success(parsedObject))
            } catch let error {
                if handleTextPlainResponse() {
                    return
                }
                
                onComplete(.failure(HttpResponseError.decodeReceivedDataFail))
                Log.network.e(category: .network, TAG, requestUrl, "- decodeReceivedDataFail: ", error)
            }

        default:
            let error = response?.error ?? HttpResponseError.undefine
            let errorResponse = CombineResponseErrorAndData(dataError: receivedData, responseError: error)
            onComplete(.failure(errorResponse))
            self.logError(error: error,
                          data: receivedData,
                          request: request)
            
            if statusCode == .unauthorized {
                handleUnauthorizedError(response: response, data: receivedData)
            }
        }
    }
    
    private func handleUnauthorizedError(response: URLResponse?, data: Data) {
        
    }

    private func logError(error: Error, data: Data?, request: URLRequest) {
        
        func errorDescription() -> Any {
            guard let e = error as? HttpResponseError else {
                return error
            }
            
            return e.errorDescription ?? e
        }
        
        let requestUrl = request.url?.absoluteString ?? ""
        
        guard let errorData = data, errorData.count > 0 else {
            Log.network.e(category: .network, TAG, requestUrl, "-", errorDescription())
            return
        }
        
        guard let errorObject = try? JSONSerialization.jsonObject(with: errorData, options: .init()) else {
            if let errorString = String(data: errorData, encoding: .utf8) {
                Log.network.e(category: .network, TAG, requestUrl, "-", errorDescription(), "\n", errorString)
            } else {
                Log.network.e(category: .network, TAG, requestUrl, "-", errorDescription())
            }
            return
        }
        
        if let errorDict = errorObject as? [String: Any] {
            Log.network.e(category: .network, TAG, requestUrl, "-", errorDescription(), "\n", errorDict.toJson(beautify: true) ?? "")
        } else {
            Log.network.e(category: .network, TAG, requestUrl, "-", errorDescription(), "\n", errorObject)
        }
    }
}
