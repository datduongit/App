//
//  ListConverter.swift
//  Networking
//
//  Created by ChungTV on 04/06/2021.
//

import Foundation

public struct ListConverter<C: IConverter>: IConverter {
    public typealias SourceType = [C.SourceType]
    
    public typealias DestinationType = [C.DestinationType]
    
    private let converter: C
    
    public init(_ converter: C) {
        self.converter = converter
    }
    
    public func convert(from sourceType: SourceType) -> DestinationType {
        var result: DestinationType = []
        for i in 0..<sourceType.count {
            result.append(converter.convert(from: sourceType[i]))
        }
        return result
    }
}
