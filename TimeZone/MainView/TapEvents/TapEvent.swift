//
//  TapEvent.swift
//  TimeZone
//
//  Created by arosenblatt on 11/16/18.
//  Copyright © 2018 Inpsiredclick. All rights reserved.
//

import Foundation

struct TapEvent {
    static let name = Notification.Name("TapEvent")
    
    enum EventType {
        case toggleMilitaryTime
    }
    
    var eventType: EventType = .toggleMilitaryTime
}
