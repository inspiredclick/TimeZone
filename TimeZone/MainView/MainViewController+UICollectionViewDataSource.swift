//
//  MainViewController+UICollectionViewDataSource.swift
//  TimeZone
//
//  Created by arosenblatt on 11/13/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//

import Foundation
import UIKit

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let header: TimeHeader = collectionView.dequeueReusableView(for: indexPath, ofKind: UICollectionView.elementKindSectionHeader)
        
        guard let viewModel = self.viewModel else {
            return header
        }
        
        header.viewModel = viewModel.data(for: indexPath)
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TimeZoneCell = collectionView.dequeueReusableCell(for: indexPath)
        
        guard let viewModel = self.viewModel else {
            return cell
        }
        
        if var cellViewModel = viewModel.data(for: indexPath) {
            cellViewModel.id = indexPath.section
            cellViewModel.militaryTime = viewModel.militaryTime
            cell.viewModel = cellViewModel
        }
        
        return cell
    }
    
}
