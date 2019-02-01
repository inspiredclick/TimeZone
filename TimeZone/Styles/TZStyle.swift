//
//  TZStyle.swift
//  TimeZone
//
//  Created by arosenblatt on 11/19/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//

import Foundation
import UIKit

struct TZStyle {
    static let blue1: UIColor = UIColor(red: 92/255, green: 73/255, blue: 114/255, alpha: 1)
    static let orange1: UIColor = UIColor(red: 197/255, green: 150/255, blue: 142/255, alpha: 1)
    
    static func backgroundGradient() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        
        gradient.colors = [TZStyle.blue1.cgColor, TZStyle.orange1.cgColor]
        gradient.locations = [0,1]
        
        return gradient
    }
}
