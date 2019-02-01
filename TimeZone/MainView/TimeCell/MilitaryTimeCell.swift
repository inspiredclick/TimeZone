//
//  MilitaryTimeCell.swift
//  TimeZone
//
//  Created by arosenblatt on 11/15/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//

import Foundation
import UIKit

class MilitaryTimeCell: UICollectionViewCell, ReusableView, NibReusableView, TimeCellType {
    
    @IBOutlet weak var timeLabel: UILabel?
    var viewModel: TimeCellViewModel? {
        didSet {
            setTime()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.cornerRadius = TimeCellStyle.cornerRadius
    }

    func setTime() {
        guard let viewModel = self.viewModel,
            let index = viewModel.index,
            let date = viewModel.startingDate else {
                return
        }
        
        var calculatedHour = date.hour() + index
        
        if 24 < calculatedHour {
            calculatedHour -= 24
        }
        
        timeLabel?.text = "\(calculatedHour)"
    }
    
}
