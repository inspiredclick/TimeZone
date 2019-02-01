//
//  EditViewDataLayer.swift
//  TimeZone
//
//  Created by arosenblatt on 11/20/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//

import Foundation
import PromiseKit

protocol EditViewDataLayerType: class {
    func getStoredTimeZones() -> [[String: [String: Any]]]
    func saveTimeZone(_ viewModel: EditCellViewModel)
    func searchRequest(_ queryString: String) -> Promise<Any>
    func removeSavedTimezone(_ viewModel: EditCellViewModel) -> Bool
}

final class EditViewDataLayer: EditViewDataLayerType {
    func getStoredTimeZones() -> [[String: [String: Any]]] {
        return TZDefaults.getTimezones()
    }
    
    func saveTimeZone(_ viewModel: EditCellViewModel) {
        TZDefaults.saveTimezone(viewModel)
    }
    
    func searchRequest(_ queryString: String) -> Promise<Any> {
        let request = TimeZoneAPI.SearchRequest(queryString: queryString, style: .full)
        return request.get()
    }
    
    func removeSavedTimezone(_ viewModel: EditCellViewModel) -> Bool {
        return TZDefaults.removeTimezone(viewModel)
    }
}
