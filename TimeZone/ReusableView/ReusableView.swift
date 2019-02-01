//
//  ReusableView.swift
//  TimeZone
//
//  Created by arosenblatt on 11/14/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//  https://medium.com/@gonzalezreal/ios-cell-registration-reusing-with-swift-protocol-extensions-and-generics-c5ac4fb5b75e
//  https://blog.bobthedeveloper.io/generic-protocols-with-associated-type-7e2b6e079ee2
//

import Foundation
import UIKit

protocol ReusableView: class {
    associatedtype ViewModel
    
    static var defaultReuseId: String { get }
    var viewModel: ViewModel? { get set }
}

extension ReusableView where Self: UIView {
    static var defaultReuseId: String {
        return String(describing: self)
    }
}
