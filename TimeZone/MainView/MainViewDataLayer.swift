//
//  MainViewDataLayer.swift
//  TimeZone
//
//  Created by arosenblatt on 11/12/18.
//  Copyright © 2018 InspiredClick. All rights reserved.
//

import Foundation

// Interactor

protocol MainViewDataLayerType {
    func getStoredTimeZones() -> [[String: [String: Any]]]
}

final class MainViewDataLayer: MainViewDataLayerType {
    func getStoredTimeZones() -> [[String: [String: Any]]] {
        return TZDefaults.getTimezones()
    }
}
