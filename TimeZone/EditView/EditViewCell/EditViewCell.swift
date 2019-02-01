//
//  EditViewCell.swift
//  TimeZone
//
//  Created by arosenblatt on 11/20/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//

import UIKit

protocol EditViewCellType: class {
    var viewModel: EditCellViewModel? { get set }
}

class EditViewCell: UITableViewCell, EditViewCellType, ReusableView, NibReusableView {
    
    @IBOutlet weak var locationLabel: UILabel?
    @IBOutlet weak var gmtLabel: UILabel?
    
    var viewModel: EditCellViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    func bindViewModel() {
        guard let viewModel = self.viewModel else {
            return
        }
        
        self.locationLabel?.text = ""
        self.gmtLabel?.text = ""
        
        if let locationLabel = viewModel.locationLabel {
            self.locationLabel?.text = locationLabel
        }
        
        if let gmtLabel = viewModel.gmtOffsetLabel {
            self.gmtLabel?.text = gmtLabel
        }
    }
}
