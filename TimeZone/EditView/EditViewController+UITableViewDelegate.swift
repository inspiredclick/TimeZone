//
//  EditViewController+UITableViewDelegate.swift
//  TimeZone
//
//  Created by arosenblatt on 11/20/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//

import UIKit

extension EditViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        guard let viewModel = self.viewModel else {
            return false
        }
        
        return viewModel.editMode
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let viewModel = self.viewModel else {
            return
        }
        
        if let cellViewModel = viewModel.data(for: indexPath) {
            if editingStyle == .delete {
                delegate?.removeTimezone(cellViewModel, indexPath: indexPath)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = self.viewModel else {
            return
        }
        
        if let cellViewModel = viewModel.data(for: indexPath) {
            delegate?.didSelectRow(cellViewModel)
        }
        
    }
}
