//
//  TimeChartCell.swift
//  TimeZone
//
//  Created by arosenblatt on 11/13/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//

import UIKit

protocol TimeZoneCellType: class {
    var viewModel: TimeZoneViewModel? { get set }
}

class TimeZoneCell: UICollectionViewCell, TimeZoneCellType, ReusableView, NibReusableView {

    @IBOutlet weak var collectionView: UICollectionView?
    var viewModel: TimeZoneViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView?.register(TimeCell.self)
        collectionView?.register(MilitaryTimeCell.self)
        
        ScrollEventCenter.register(self, selector: #selector(onScrollEvent(notification:)))
    }
    
    func bindViewModel() {
        collectionView?.reloadData()
    }

    @objc func onScrollEvent(notification: NSNotification) {
        guard let scrollEvent = notification.object as? ScrollEvent,
            let viewModel = self.viewModel else {
            return
        }

        if scrollEvent.shouldSetScrollOffset(viewModel.id, ignoreScrollEvents: viewModel.ignoreScrollEvents) {
            self.collectionView?.setContentOffset(scrollEvent.scrollOffset, animated: false)
        }
        else if scrollEvent.eventType == .decellerate && scrollEvent.senderId == viewModel.id {
            self.viewModel?.ignoreScrollEvents = true
        }
        else if scrollEvent.eventType == .endDecellerate {
            self.viewModel?.ignoreScrollEvents = false
        }
        else if scrollEvent.eventType == .willBeginDragging {
            self.viewModel?.ignoreScrollEvents = false
        }
    }
}
