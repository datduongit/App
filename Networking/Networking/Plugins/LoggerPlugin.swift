//
//  LoggerPlugin.swift
//  ami-ios-base-customer
//
//  Created by Edric D. on 21/01/2021.
//

import Moya

// MARK: - Logger
struct LoggerPlugin: PluginType {
    let verbose: Bool
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        #if DEBUG
        print("----------------------------------------------------")
        print("--------------request---------------: \(request.url!)")
        print("--------------headers---------------: \(request.allHTTPHeaderFields!)")
        print("--------------method----------------: \(request.httpMethod!)")
        if let httpBody = request.httpBody, let result = ((try? JSONSerialization.jsonObject(with: httpBody, options: []) as? [String: AnyObject]) as [String: AnyObject]??) {
            print("-----------body: \(String(describing: result))")
        } else if let httpBody = request.httpBody, let resultString = String(data: httpBody, encoding: .utf8) {
            print("-----------body: \(String(describing: resultString))")
        }
        return request
        #else
        return request
        #endif
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        #if DEBUG
        guard verbose else { return }
        if case let .success(body) = result {
            print("-----------Response----------: \n", target.baseURL.appendingPathComponent(target.path))
            if let json = try? JSONSerialization.jsonObject(with: body.data, options: .mutableContainers) {
                print(json)
            } else {
                let response = String(data: body.data, encoding: .utf8)!
                print(response)
            }
        }
        #endif
    }
}
