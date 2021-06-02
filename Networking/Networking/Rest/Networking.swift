//
//  Networking.swift
//  ami-ios-base-customer
//
//  Created by Edric D. on 21/01/2021.
//

import Moya
import MoyaSugar
import RxSwift
import ObjectMapper

private let success = "success"
private let status =  "status"

public struct Status: Mappable {
    public var response: Response?
    public var code: String = ""
    public var message: String = ""
    public var newCode: String = ""
    public var englishMessage: String?
    public var localMessage: String?
    
    public init(response: Response) throws {
        self.response = response
        self = try response.mapObject(Status.self, atKeyPath: status)
    }
    
    public init?(map: Map) { }
    
    public mutating func mapping(map: Map) {
        code            <- map["code"]
        message         <- map["message"]
        newCode         <- map["new_code"]
        englishMessage  <- map["english_message"]
        localMessage    <- map["local_message"]
    }
}

public class BaseResponseModel<T>: Mappable where T: Mappable {
    public var status: Status?
    public var data: T?
    
    required public init?(map: Map) {
        self.mapping(map: map)
    }
    
    public func mapping(map: Map) {
        status <- map["status"]
        data   <- map["data"]
    }
}

public struct ResponseError: Error, Mappable {
    static let unknown = ResponseError()
    
    public var response: Response?
    public var status: Status?
    
    public init(status: Status? = nil, response: Response? = nil) {
        self.status = status
        self.response = response
    }
    
    public init(response: Response) throws {
        self = try response.mapObject(ResponseError.self)
        self.response = response
    }
    
    public init?(map: Map) { }
    
    public mutating func mapping(map: Map) {
        self.status <- map["status"]
    }
}

/// Base networking

public protocol NetworkingType {
    associatedtype T: BaseTargetType
    
    var provider: Networking<T> { get }
    
    static func makeProvider() -> Self
}

open class Networking<Target: SugarTargetType>: MoyaSugarProvider<Target> {
    
    public init(
        requestClosure: @escaping RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
        stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
        plugins: [PluginType] = []
    ) {
        super.init(
            requestClosure: requestClosure,
            stubClosure: stubClosure,
            session: DefaultAlamofireSession.shared,
            plugins: plugins + NetworkPluginFactory.makeDefaultPlugins()
        )
    }
    
    public func request(_ target: Target) -> Single<Response> {
        rx.request(target)
            .flatMap { response -> Single<Response> in
                Single.create(subscribe: { observer in
                    do {
                        let status = try Status(response: response)
                        if status.code == success {
                            observer(.success(response))
                        } else {
                            if let responseError = try? ResponseError(response: response) {
                                observer(.error(responseError))
                            } else {
                                observer(.error(ResponseError.unknown))
                            }
                        }
                    } catch {
                        if let error = error as? MoyaError,
                           let response = error.response,
                           let responseError = try? ResponseError(response: response) {
                            observer(.error(responseError))
                        } else {
                            observer(.error(ResponseError.unknown))
                        }
                    }
                    return Disposables.create()
                })
            }
    }
    
}

/// End

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    public func mapError<T>(_ errorType: T.Type) -> Single<Element> where T: ResponseErrorInjectable & Error {
        catchError { err -> Single<Element> in
            guard let error = err as? ResponseError,
                  let result = try? T(responseError: error)
            else { return Single.error(err) }
            return Single.error(result)
        }
    }
    
    public func mapError<T>(_ errorType: T.Type, conditional: @escaping (ResponseError) -> Bool) -> Single<Element> where T: ResponseErrorInjectable & Error {
        catchError { err -> Single<Element> in
            if let error = err as? ResponseError,
                let result = try? T(responseError: error),
                conditional(error) {
                return Single.error(result)
            }
            return Single.error(err)
        }
    }
    
    public func catchResponseError(_ handler: @escaping (ResponseError) throws -> Single<Element>) -> Single<Element> {
        catchError { err -> Single<Element> in
            guard let error = err as? ResponseError
            else { return Single.error(err) }
            return try handler(error)
        }
    }
}

public protocol ResponseErrorInjectable {
    init(responseError: ResponseError) throws
}

public protocol HasResponseError {
    var responseError: ResponseError { get }
}
