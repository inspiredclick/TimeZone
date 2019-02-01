//
//  UICollectionView+Utils.swift
//  TimeZone
//
//  Created by arosenblatt on 11/14/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//

import Foundation
import UIKit

protocol ReusableRegistry: class {
    func register<C>(_: C.Type) where C: ReusableView
    func register<C>(_: C.Type) where C: ReusableView, C: NibReusableView
    func dequeueReusableCell<C>(for indexPath: IndexPath) -> C where C: ReusableView
}

extension UICollectionView: ReusableRegistry {
    
    //UICollectionReusableView
    func registerReusableView<C: UICollectionReusableView>(_: C.Type, ofKind: String) where C: ReusableView {
        register(C.self, forSupplementaryViewOfKind: ofKind, withReuseIdentifier: C.defaultReuseId)
    }
    
    func registerReusableView<C: UICollectionReusableView>(_: C.Type, ofKind: String) where C: ReusableView, C: NibReusableView {
        let nib = UINib(nibName: C.nibName, bundle: nil)
        
        register(nib, forSupplementaryViewOfKind: ofKind, withReuseIdentifier: C.defaultReuseId)
    }
    
    func dequeueReusableView<C: UICollectionReusableView>(for indexPath: IndexPath, ofKind: String) -> C where C: ReusableView {
        guard let reusableView = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: C.defaultReuseId,
            for: indexPath) as? C else {
                fatalError("Could not dequeue with identifier \(C.defaultReuseId)")
        }
        
        return reusableView
    }
    
    // UICollectionViewCell
    func register<C>(_: C.Type) where C: ReusableView {
        register(C.self, forCellWithReuseIdentifier: C.defaultReuseId)
    }
    
    func register<C>(_: C.Type) where C: ReusableView, C: NibReusableView {
        let nib = UINib(nibName: C.nibName, bundle: nil)
        
        register(nib, forCellWithReuseIdentifier: C.defaultReuseId)
    }
    
    func dequeueReusableCell<C>(for indexPath: IndexPath) -> C where C: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: C.defaultReuseId, for: indexPath) as? C else {
            fatalError("Could not dequeue with identifier \(C.defaultReuseId)")
        }
        
        return cell
    }
}

extension UITableView: ReusableRegistry {
    func register<C>(_: C.Type) where C: ReusableView {
        register(C.self, forCellReuseIdentifier: C.defaultReuseId)
    }
    
    func register<C>(_: C.Type) where C: ReusableView, C: NibReusableView {
        let nib = UINib(nibName: C.nibName, bundle: nil)
        
        register(nib, forCellReuseIdentifier: C.defaultReuseId)
    }
    
    func dequeueReusableCell<C>(for indexPath: IndexPath) -> C where C : ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: C.defaultReuseId, for: indexPath) as? C else {
            fatalError("Could not dequeue with identifier \(C.defaultReuseId)")
        }
        
        return cell
    }
}
