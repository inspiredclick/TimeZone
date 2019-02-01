//
//  TimeHeader.swift
//  TimeZone
//
//  Created by arosenblatt on 11/16/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//

import UIKit

class TimeHeader: UICollectionReusableView, ReusableView, NibReusableView {
    
    @IBOutlet weak var titleLabel: UILabel?
    
    var viewModel: TimeZoneViewModel? {
        didSet {
            if let titleText = viewModel?.locationLabel {
                titleLabel?.text = titleText
            }
        }
    }
    
}
