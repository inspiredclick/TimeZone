//
//  ScrollEventCenter.swift
//  TimeZone
//
//  Created by arosenblatt on 11/14/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//

import Foundation

struct ScrollEventCenter {
    static func register(_ observer: AnyObject, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: ScrollEvent.name, object: nil)
    }
    
    static func dispatch(_ scrollEvent: ScrollEvent) {
        NotificationCenter.default.post(name: ScrollEvent.name, object: scrollEvent)
    }
}
