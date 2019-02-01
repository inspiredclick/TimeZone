//
//  EditCellViewModel.swift
//  TimeZone
//
//  Created by arosenblatt on 11/20/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//

import Foundation
import SwiftyJSON

struct EditCellViewModel {
    
    var gmtOffset: Float?
    var dstOffset: Float?
    var geonameId: String?
    var gmtOffsetLabel: String?
    var locationLabel: String?
    
}

extension EditCellViewModel {
    static func map(_ data: JSON) -> EditCellViewModel {
        var editCellViewModel = EditCellViewModel()
        editCellViewModel.gmtOffset = data["timezone"]["gmtOffset"].float
        editCellViewModel.dstOffset = data["timezone"]["dstOffset"].float
        
        if let geonameId = data["geonameId"].int {
            editCellViewModel.geonameId = "\(geonameId)"
        }
        
        if let gmtOffset = data["timezone"]["gmtOffset"].float {
            editCellViewModel.gmtOffsetLabel = "GMT \(gmtOffset)"
        }
        
        if let name = data["asciiName"].string,
            let country = data["countryCode"].string {
            
            if country.lowercased() == "us",
                let state = data["adminCode1"].string {
                editCellViewModel.locationLabel = "\(name), \(state), \(country)"
            }
            else {
                editCellViewModel.locationLabel = "\(name), \(country)"
            }
        }
        
        return editCellViewModel
    }
}

extension EditCellViewModel {
    
    enum DictKeys: String {
        case gmtOffset
        case dstOffset
        case geonameId
        case gmtOffsetLabel
        case locationLabel
    }
    
    func toDict() -> [String: Any] {
        guard geonameId != nil else {
            return [:]
        }
        
        var values: [String: Any] = [:]
        
        values[DictKeys.gmtOffset.rawValue] = gmtOffset
        values[DictKeys.dstOffset.rawValue] = dstOffset
        values[DictKeys.geonameId.rawValue] = geonameId
        values[DictKeys.gmtOffsetLabel.rawValue] = gmtOffsetLabel
        values[DictKeys.locationLabel.rawValue] = locationLabel
        
        return values
    }
    
    static func fromDict(_ dict: [String: Any]) -> EditCellViewModel {
        var cellViewModel = EditCellViewModel()
        
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
