//
//  AppRouter.swift
//  TimeZone
//
//  Created by arosenblatt on 11/12/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//

import Foundation
import UIKit

protocol AppRouterType: class {
    func openEditView(_ mainView: MainViewType)
}

final class AppRouter: AppRouterType {
    
    struct Segue {
        static let editSegue: String = "EditSegue"
    }
    
    func openEditView(_ mainView: MainViewType) {
        guard let viewController = mainView as? UIViewController else {
            return
        }
        
        viewController.performSegue(withIdentifier: Segue.editSegue, sender: viewController)
    }
}
