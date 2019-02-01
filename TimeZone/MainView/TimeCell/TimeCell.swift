//
//  TimeCell.swift
//  TimeZone
//
//  Created by arosenblatt on 11/13/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//

import UIKit

protocol TimeCellType: class {
    var timeLabel: UILabel? { get set }
    func setTime()
}

struct TimeCellStyle {
    static let cornerRadius: CGFloat = 5.0
}

class TimeCell: UICollectionViewCell, ReusableView, NibReusableView, TimeCellType {

    @IBOutlet weak var timeLabel: UILabel?
    @IBOutlet weak var amPmLabel: UILabel?
    
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
        
        if 12 < calculatedHour {
            calculatedHour -= 12
            amPmLabel?.text = "PM"
            
            if 12 < calculatedHour {
                calculatedHour -= 12
                amPmLabel?.text = "AM"
            }
            
            if 12 < calculatedHour {
                calculatedHour -= 12
                amPmLabel?.text = "PM"
            }
        }
        else {
            amPmLabel?.text = "AM"
        }
        
        timeLabel?.text = "\(calculatedHour)"
    }

}
