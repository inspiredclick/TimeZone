//
//  EditViewModel.swift
//  TimeZone
//
//  Created by arosenblatt on 11/20/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//

import Foundation
import SwiftyJSON

struct EditViewModel: Countable {
    
    var savedTimeZones: [EditCellViewModel] = []
    var editMode: Bool = true
    var searchResults: [EditCellViewModel] = []

    func hasDataFor(indexPath: IndexPath) -> Bool {
        if editMode {
            return indexPath.row < savedTimeZones.count
        }
        return indexPath.row < searchResults.count
    }
    
    func data(for indexPath: IndexPath) -> EditCellViewModel? {
        guard hasDataFor(indexPath: indexPath) else {
            return nil
        }
        
        if editMode {
            return savedTimeZones[indexPath.row]
        }
        
        return searchResults[indexPath.row]
    }
    
    func count() -> Int {
        if editMode {
            return savedTimeZones.count
        }
        return searchResults.count
    }
}

extension EditViewModel {
    mutating func toggleEditMode() {
        editMode = !editMode
    }
}

extension EditViewModel {
    static func mapSearchResults(_ response: TimeZoneAPI.SearchRequestResponse) -> [EditCellViewModel] {
        guard let data = response.data else {
            return []
        }
        
        var searchResults: [EditCellViewModel] = []
        
        data["geonames"].forEach { (key, geoData) in
            let editCellViewModel = EditCellViewModel.map(geoData)
            searchResults.append(editCellViewModel)
        }
        
        return searchResults
    }
}
