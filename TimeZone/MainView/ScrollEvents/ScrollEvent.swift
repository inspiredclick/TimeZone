//
//  ScrollEvent.swift
//  TimeZone
//
//  Created by arosenblatt on 11/14/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//

import Foundation
import UIKit

struct ScrollEvent {
    
    static let name = Notification.Name("ScrollEvent")
    
    enum EventType {
        case scroll
        case decellerate
        case endDecellerate
        case willBeginDragging
    }
    
    var scrollOffset: CGPoint = CGPoint(x: 0, y: 0)
    var senderId: Int?
    var eventType: EventType = .scroll
    
    func shouldSetScrollOffset(_ id: Int?, ignoreScrollEvents: Bool) -> Bool {
        return eventType == .scroll && senderId != id && !ignoreScrollEvents
    }
}
