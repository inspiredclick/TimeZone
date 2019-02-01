//
//  TapEventCenter.swift
//  TimeZone
//
//  Created by arosenblatt on 11/16/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//

import Foundation

struct TapEventCenter {
    static func register(_ observer: AnyObject, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: TapEvent.name, object: nil)
    }
    static func dispatch(_ tapEvent: TapEvent) {
        NotificationCenter.default.post(name: TapEvent.name, object: tapEvent)
    }
}
