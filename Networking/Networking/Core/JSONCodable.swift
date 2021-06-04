//
//  JSONCodable.swift
//  Networking
//
//  Created by ChungTV on 03/06/2021.
//

import Foundation

open class HTTPDecoding {
    open class Factory {
        public init() {
            
        }
        public func create() -> JSONDecoder {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }
    }
}

open class HTTPEncoding {
    open class Factory {
        public init() {
            
        }
        public func create() -> JSONEncoder {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return encoder
        }
    }
}
