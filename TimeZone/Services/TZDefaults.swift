//
//  TZDefaults.swift
//  TimeZone
//
//  Created by arosenblatt on 11/24/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//

import Foundation
import SwiftyJSON

struct TZDefaults {
    enum Keys: String {
        case timezones
    }
    
    static let userDefault = UserDefaults.standard
    
    static var timeZones: [[String: [String: Any]]] {
        get {
            return userDefault.array(forKey: Keys.timezones.rawValue) as? [[String: [String: Any]]] ?? []
        }
        set {
            userDefault.set(newValue, forKey: Keys.timezones.rawValue)
        }
    }
}

extension TZDefaults {
    static func saveTimezone(_ viewModel: EditCellViewModel) {
        guard let geonameId = viewModel.geonameId else {
            return
        }
        
        timeZones.append([geonameId: viewModel.toDict()])
    }
}

extension TZDefaults {
    static func getTimezones() -> [[String: [String: Any]]] {
        return timeZones
    }
}

extension TZDefaults {
    static func removeTimezone(_ viewModel: EditCellViewModel) -> Bool {
        if let index = timeZones.firstIndex(where: { $0.keys.first == viewModel.geonameId }) {
            timeZones.remove(at: index)
            return true
        }
        
        return false
    }
}
