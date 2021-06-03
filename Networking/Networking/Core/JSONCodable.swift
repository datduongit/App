//
//  JSONCodable.swift
//  Networking
//
//  Created by ChungTV on 03/06/2021.
//

import Foundation

class HTTPDecoding {
    class Factory {
        func create() -> JSONDecoder {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }
    }
}

class HTTPEncoding {
    class Factory {
        func create() -> JSONEncoder {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return encoder
        }
    }
}
