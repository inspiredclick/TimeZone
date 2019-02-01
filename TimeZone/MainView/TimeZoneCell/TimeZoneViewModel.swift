//
//  TimeZoneViewModel.swift
//  TimeZone
//
//  Created by arosenblatt on 11/13/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//

import Foundation

struct TimeZoneViewModel {
    let numberOfHours: Int = 24
    var id: Int?
    
    var ignoreScrollEvents: Bool = false
    var militaryTime: Bool = false
    
    var gmtOffset: Float?
    var dstOffset: Float?
    var geonameId: String?
    var gmtOffsetLabel: String?
    var locationLabel: String?
    
    func shouldSendEvent() -> Bool {
        return !ignoreScrollEvents
    }
    
    func calculateHour() -> Date? {
        let offset = Float(gmtOffset ?? 0)
        
        guard let date = Date().adding(hours: offset) else {
            return nil
        }
        
        return date
    }
}

extension TimeZoneViewModel {
    enum DictKeys: String {
        case gmtOffset
        case dstOffset
        case geonameId
        case gmtOffsetLabel
        case locationLabel
    }
    
    static func fromDict(_ dict: [String: Any]) -> TimeZoneViewModel {
        var cellViewModel = TimeZoneViewModel()
        
        if let gmtOffset = dict[DictKeys.gmtOffset.rawValue] as? Float {
            cellViewModel.gmtOffset = gmtOffset
        }
        
        if let dstOffset = dict[DictKeys.dstOffset.rawValue] as? Float {
            cellViewModel.dstOffset = dstOffset
        }
        
        if let geonameId = dict[DictKeys.geonameId.rawValue] as? String {
            cellViewModel.geonameId = geonameId
        }
        
        if let gmtOffsetLabel = dict[DictKeys.gmtOffsetLabel.rawValue] as? String {
            cellViewModel.gmtOffsetLabel = gmtOffsetLabel
        }
        
        if let locationLabel = dict[DictKeys.locationLabel.rawValue] as? String {
            cellViewModel.locationLabel = locationLabel
        }
        
        return cellViewModel
    }
}
