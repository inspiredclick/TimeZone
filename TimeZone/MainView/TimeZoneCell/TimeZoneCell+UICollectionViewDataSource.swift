//
//  TimeZoneCell+UICollectionViewDataSource.swift
//  TimeZone
//
//  Created by arosenblatt on 11/13/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//

import UIKit

extension TimeZoneCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = self.viewModel else {
            return 0
        }
        return viewModel.numberOfHours
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = self.viewModel else {
            fatalError("View model not available")
        }
        
        var timeCellViewModel = TimeCellViewModel()
        timeCellViewModel.index = indexPath.row
        timeCellViewModel.startingDate = viewModel.calculateHour()
        
        if viewModel.militaryTime {
            let milCell: MilitaryTimeCell = collectionView.dequeueReusableCell(for: indexPath)
            
            milCell.viewModel = timeCellViewModel
            
            return milCell
        }
        
        let cell: TimeCell = collectionView.dequeueReusableCell(for: indexPath)
        
        cell.viewModel = timeCellViewModel
        
        return cell
    }
    
}
