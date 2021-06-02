//
//  Foundation+Extension.swift
//  Utility
//
//  Created by Robert on 23/04/2021.
//

import Foundation

extension Bool {
    public init(value: Int) {
        self = value > 0
    }
}

extension Int {
    public var boolValue: Bool {
        Bool(value: self)
    }
}
