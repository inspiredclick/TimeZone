//
//  MainViewModel.swift
//  TimeZone
//
//  Created by arosenblatt on 11/12/18.
//  Copyright © 2018 InspiredClick. All rights reserved.
//

import Foundation

struct MainViewModel: Countable {
    
    var timeZones: [TimeZoneViewModel] = []
    var militaryTime: Bool = false
    
    func hasDataFor(indexPath: IndexPath) -> Bool {
        return indexPath.section < timeZones.count
    }
    
    func data(for indexPath: IndexPath) -> TimeZoneViewModel? {
        guard hasDataFor(indexPath: indexPath) else {
            return nil
        }
        
        return timeZones[indexPath.section]
    }
}

extension MainViewModel {
    mutating func toggleMilitaryTime() {
        militaryTime = !militaryTime
    }
}
