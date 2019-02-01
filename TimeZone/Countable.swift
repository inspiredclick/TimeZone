//
//  Countable.swift
//  TimeZone
//
//  Created by arosenblatt on 11/14/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//

import Foundation

protocol Countable {
    associatedtype ViewModel
    
    func hasDataFor(indexPath: IndexPath) -> Bool
    func data(for indexPath: IndexPath) -> ViewModel?
}
