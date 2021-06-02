//
//  Date+Utils.swift
//  Utility
//
//  Created by Edric D. on 19/02/2021.
//

import Foundation

public extension Date {
    
    func days(to date: Date) -> Int? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self, to: date)
        return components.day
    }
    
    func minutes(to date: Date) -> Int? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: self, to: date)
        return components.minute
    }
    
    func seconds(to date: Date) -> Int? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.second], from: self, to: date)
        return components.second
    }

}
