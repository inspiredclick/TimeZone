//
//  Date+Utils.swift
//  TimeZone
//
//  Created by arosenblatt on 11/25/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//

import Foundation

extension Date {
    
    private func gmtCalendar() -> Calendar {
        var cal = Calendar(identifier: .gregorian)
        if let tz = TimeZone(secondsFromGMT: 0) {
            cal.timeZone = tz
        }
        
        return cal
    }
    
    func adding(hours: Float) -> Date? {
        let hour = Int(hours)
        let minutes = (hours.truncatingRemainder(dividingBy: 1) > 0) ? 30 : 0
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minutes
        
        return gmtCalendar().date(byAdding: dateComponents, to: self)
    }
    
    func hour() -> Int {
        return gmtCalendar().component(.hour, from: self)
    }
}
