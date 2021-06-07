//
//  DictionUtls.swift
//  App
//
//  Created by ChungTV on 07/06/2021.
//

import Foundation
import Logger

extension Dictionary {
    func toJSON(beautify: Bool = false) -> String {
        do {
            let options: JSONSerialization.WritingOptions
            if #available(iOS 11.0, *) {
                options = beautify ? [.prettyPrinted, .sortedKeys] : .init()
            } else {
                options = beautify ? .prettyPrinted : .init()
            }
            let data = try JSONSerialization.data(withJSONObject: self,
                                                  options: options)
            return String(data: data, encoding: .utf8) ?? ""
        } catch {
            Log.e(#function, "error:", error.localizedDescription)
            return ""
        }
    }

    func compactMapValues<U>(_ transform: (Value) throws -> U?) rethrows -> [Key: U] {
        var result = [Key: U]()
        for (key, value) in self {
            result[key] = try transform(value)
        }

        return result
    }
    
    func mapKeys<NewKey>(_ mapping: (Key) -> NewKey) -> [NewKey: Value] where NewKey: Hashable {
        var newDict = [NewKey: Value]()
        for (key, value) in self {
            newDict[mapping(key)] = value
        }
        return newDict
    }

    func dictionary(forKey key: Key) -> Dictionary? {
        return self[key] as? Dictionary
    }

    func double(forKey key: Key) -> Double? {
        return self[key] as? Double
    }
    func int(forKey key: Key) -> Int? {
        return self[key] as? Int
    }

    mutating func add(_ dictionary: Dictionary) {
        for (k, v) in dictionary {
            self[k] = v
        }
    }
    
    subscript(key: Key?) -> Value? {
        guard let key = key else { return nil }
        return self[key]
    }
}
