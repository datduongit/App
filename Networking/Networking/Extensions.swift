//
//  Extensions.swift
//  Networking
//
//  Created by ChungTV on 03/06/2021.
//

import Foundation

extension Dictionary {
    public func toJson(beautify: Bool = false) -> String? {
        guard let data = try? JSONSerialization.data(
            withJSONObject: self,
            options: beautify ? .prettyPrinted : .init()) else {
                return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    mutating func join(_ other: [Key: Value?]) {
        other.compactMapValues({ $0 }).forEach({ self[$0.key] = $0.value })
    }
    
    public func joined(_ other: [Key: Value?]) -> [Key: Value] {
        var dict = self
        dict.join(other)
        return dict
    }
}
