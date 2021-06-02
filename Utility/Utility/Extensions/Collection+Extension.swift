//
//  Collection+Extension.swift
//  Utility
//
//  Created by Robert on 03/04/2021.
//

import Foundation

extension Collection {
    public subscript(safe index: Index) -> Self.Element? {
        indices.contains(index) ? self[index] : nil
    }
}
