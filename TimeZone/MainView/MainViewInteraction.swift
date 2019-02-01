//
//  MainViewInteraction.swift
//  TimeZone
//
//  Created by arosenblatt on 11/12/18.
//  Copyright © 2018 InspiredClick. All rights reserved.
//

import Foundation
import PromiseKit

// Presenter

protocol MainViewInteractionType: class {
    func loadTimeZones() -> Promise<MainViewModel>
    func toggleMilitaryTime()
    func tapEditButton()
}

final class MainViewInteraction: Interaction<MainViewType, MainViewDataLayerType>, MainViewInteractionType {
    private var router: AppRouterType?
    
    override init(view: MainViewType, dataLayer: MainViewDataLayerType = appContainer.resolve(MainViewDataLayerType.self)!) {
        self.router = appContainer.resolve(AppRouterType.self)
        
        super.init(view: view, dataLayer: dataLayer)
    }
    
    func loadTimeZones() -> Promise<MainViewModel> {
        return Promise<MainViewModel> { promise in
            var viewModel = MainViewModel()
            
            dataLayer.getStoredTimeZones().forEach({ (dictArray) in
                for tzDict in dictArray {
                    viewModel.timeZones.append(TimeZoneViewModel.fromDict(tzDict.value))
                }
            })
            
            promise.fulfill(viewModel)
        }
    }
    
    func toggleMilitaryTime() {
        self.view.viewModel?.toggleMilitaryTime()
    }
    
    func tapEditButton() {
        self.router?.openEditView(self.view)
    }
}
