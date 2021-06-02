//
//  Number+Extension.swift
//  Utility
//
//  Created by Robert on 02/03/2021.
//

import Foundation

func threadSharedObject<T: AnyObject>(key: String, create: () -> T) -> T {
    if let cachedObj = Thread.current.threadDictionary[key] as? T {
        return cachedObj
    } else {
        let newObject = create()
        Thread.current.threadDictionary[key] = newObject
        return newObject
    }
}

extension Double {
    public func toDecimalBalanceString(locale: Locale = Locale(identifier: "en"), maximumFractionDigits: Int) -> String {
        let numberFormatter: NumberFormatter = threadSharedObject(key: "Utility_NumberFormatter_Decimal") {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = maximumFractionDigits
            formatter.roundingMode = .down
            return formatter
        }
        numberFormatter.locale = locale
        numberFormatter.maximumFractionDigits = min(maximumFractionDigits, 2) // 2 is maximum fraction digits of this app
        numberFormatter.minimumFractionDigits = min(maximumFractionDigits, 2)
        guard let formattedNumber = numberFormatter.string(from: NSNumber(value: self)) else {
            if floor(self) == self {
                return "\(String(Int64(self))).\(Array(repeating: "0", count: maximumFractionDigits).joined())"
            } else {
                return String(self)
            }
        }
        let limitedCharCount = maximumFractionDigits == 0 ? 15 : 16  // 12 + 3 or 4 punctuation marks
        if formattedNumber.count > limitedCharCount {
            var result = formattedNumber.suffix(limitedCharCount)
            if let lastChar = result.first {
                if !lastChar.isNumber {
                    result.removeFirst()
                }
                result.insert(contentsOf: "...", at: result.startIndex)
            }
            return String(result)
        }
        return formattedNumber
    }
}
