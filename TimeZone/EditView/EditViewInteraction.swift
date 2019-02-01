//
//  EditViewInteraction.swift
//  TimeZone
//
//  Created by arosenblatt on 11/20/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//

import Foundation
import PromiseKit

protocol EditViewInteractionType: class {
    func loadTimeZones() -> Promise<[EditCellViewModel]>
    func locationSearch(_ searchQuery: String) -> Promise<[EditCellViewModel]>
    func toggleViewMode()
    func didSelectRow(_ viewModel: EditCellViewModel)
    func searchCanceled()
    func removeTimezone(_ viewModel: EditCellViewModel, indexPath: IndexPath)
}

final class EditViewInteraction: Interaction<EditViewType, EditViewDataLayerType>, EditViewInteractionType {
    
    private var router: AppRouterType?
    
    override init(view: EditViewType, dataLayer: EditViewDataLayerType = appContainer.resolve(EditViewDataLayerType.self)!) {
        self.router = appContainer.resolve(AppRouterType.self)
        
        super.init(view: view, dataLayer: dataLayer)
    }
    
    func loadTimeZones() -> Promise<[EditCellViewModel]> {
        return Promise { promise in
            var cells: [EditCellViewModel] = []
            
            dataLayer.getStoredTimeZones().forEach { (dictArray) in
                for tzDict in dictArray {
                    cells.append(EditCellViewModel.fromDict(tzDict.value))
                }
            }
            
            promise.fulfill(cells)
        }
    }
    
    func locationSearch(_ searchQuery: String) -> Promise<[EditCellViewModel]> {
        return dataLayer.searchRequest(searchQuery).map {
            return EditViewModel.mapSearchResults($0 as! TimeZoneAPI.SearchRequestResponse)
        }
    }
    
    func toggleViewMode() {
        view.viewModel?.toggleEditMode()
    }
    
    func didSelectRow(_ viewModel: EditCellViewModel) {
        dataLayer.saveTimeZone(viewModel)
        
        view.viewModel?.toggleEditMode()
        
        view.searchBar?.resignFirstResponder()
        view.searchBar?.setShowsCancelButton(false, animated: true)
        view.searchBar?.text = ""
        
        _ = loadTimeZones().done { (viewModels) in
            self.view.viewModel?.savedTimeZones = viewModels
        }
    }
    
    func searchCanceled() {
        view.viewModel?.searchResults = []
        
        view.delegate?.toggleViewMode()
        
        view.searchBar?.resignFirstResponder()
        view.searchBar?.setShowsCancelButton(false, animated: true)
    }
    
    func removeTimezone(_ viewModel: EditCellViewModel, indexPath: IndexPath) {
        guard dataLayer.removeSavedTimezone(viewModel) else {
            return
        }
        
        _ = loadTimeZones().done { (viewModels) in
            self.view.viewModel?.savedTimeZones = viewModels
        }
    }
}
