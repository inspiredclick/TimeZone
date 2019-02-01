//
//  EditViewController+SearchBarDelegate.swift
//  TimeZone
//
//  Created by arosenblatt on 11/23/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//

import UIKit

extension EditViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        delegate?.toggleViewMode()
        
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        delegate?.searchCanceled()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            return
        }
        
        let searchResponse = delegate?.locationSearch(searchText)
        _ = searchResponse?.done({ (editViewCells) in
            self.viewModel?.searchResults = editViewCells
            self.tableView?.reloadData()
        })
        
        _ = searchResponse?.catch({ (err) in
            print(err)
        })
    }
}
