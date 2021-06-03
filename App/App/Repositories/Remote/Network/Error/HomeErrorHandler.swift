//
//  AuthErrorHandler.swift
//  MAAuthentication
//
//  Created by Edric D. on 21/02/2021.
//

import Networking
import ObjectMapper

protocol ErrorRepresentation {
    var title: String { get }
    var message: String { get }
    var underlyingCode: String { get }
    var underlyingMessage: String { get }
}

extension ErrorRepresentation {
    var title: String {
        return "Error (\(underlyingCode))"
    }
}

//extension ErrorRepresentation where Self: HasResponseError {
//    var underlyingCode: String {
//        return responseError.status?.code ?? ""
//    }
//    
//    var underlyingMessage: String {
//        return responseError.status?.message ?? ""
//    }
//}
//
//struct CheckPhoneNumberError: Error, ResponseErrorInjectable, HasResponseError {
//    enum Case {
//        case existingInSystem
//        case accountSuspended
//        case unauthorizedClient
//    }
//    
//    public var `case`: Case
//    public var data: Data?
//    public var responseError: ResponseError
//    
//    public init(responseError: ResponseError) throws {
//        self.responseError = responseError
//        
//        switch responseError.status?.code {
//        case "unauthorized_client": self.case = .unauthorizedClient
//        
//        default: throw responseError
//        }
//    }
//}
