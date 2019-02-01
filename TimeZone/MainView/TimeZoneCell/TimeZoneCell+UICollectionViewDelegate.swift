//
//  TimeChartCell+UICollectionViewDelegate.swift
//  TimeZone
//
//  Created by arosenblatt on 11/13/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//

import UIKit

extension TimeZoneCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        TapEventCenter.dispatch(TapEvent())
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        ScrollEventCenter.dispatch(
            ScrollEvent(scrollOffset: scrollView.contentOffset,
                        senderId: self.viewModel?.id,
                        eventType: .scroll)
        )
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        ScrollEventCenter.dispatch(
            ScrollEvent(scrollOffset: scrollView.contentOffset,
                        senderId: self.viewModel?.id,
                        eventType: .willBeginDragging)
        )
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        ScrollEventCenter.dispatch(
            ScrollEvent(scrollOffset: scrollView.contentOffset,
                        senderId: self.viewModel?.id,
                        eventType: .decellerate)
        )
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        ScrollEventCenter.dispatch(
            ScrollEvent(scrollOffset: scrollView.contentOffset,
                        senderId: self.viewModel?.id,
                        eventType: .endDecellerate)
        )
    }
}
