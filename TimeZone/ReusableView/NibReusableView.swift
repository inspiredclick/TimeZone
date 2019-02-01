//
//  NibReusableView.swift
//  TimeZone
//
//  Created by arosenblatt on 11/14/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//

import Foundation
import UIKit

protocol NibReusableView: class {
    static var nibName: String { get }
}

extension NibReusableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
