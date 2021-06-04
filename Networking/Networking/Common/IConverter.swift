//
//  IConverter.swift
//  Networking
//
//  Created by ChungTV on 04/06/2021.
//

import Foundation

public protocol IConverter {
    associatedtype SourceType
    associatedtype DestinationType
    func convert(from sourceType: SourceType) -> DestinationType
}
