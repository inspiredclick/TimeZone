//
//  UIViewController+ViewUtils.swift
//  TimeZone
//
//  Created by arosenblatt on 11/19/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func updateGradientFrame(_ gradient: CAGradientLayer) {
        gradient.frame = view.bounds
    }
    
    func styleNavBar() {
        guard let navController = self.navigationController else {
            return
        }
        
        navController.navigationBar.barTintColor = TZStyle.blue1
        navController.navigationBar.isTranslucent = false
        navController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
