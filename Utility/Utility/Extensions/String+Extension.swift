//
//  String+Utils.swift
//  Utility
//
//  Created by Edric D. on 19/02/2021.
//

extension Optional where Wrapped: Collection {
    public var isNilOrEmpty: Bool {
        switch self {
        case .none:
            return true
        case .some(let value):
            return value.isEmpty
        }
    }
}

public func +(_ lhs: String?, _ rhs: String?) -> String? {
    if let lhs = lhs {
        if let rhs = rhs {
            return lhs + rhs
        } else {
            return lhs
        }
    } else {
        return rhs
    }
}

extension String {
    
    public func applyPatternOnNumbers(pattern: String, replacmentCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: self)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacmentCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
}

extension StringProtocol {
    
    /// Returns the string with only [0-9], all other characters are filtered out
    var digitsOnly: String {
        return String(filter(("0"..."9").contains))
    }
    
}
