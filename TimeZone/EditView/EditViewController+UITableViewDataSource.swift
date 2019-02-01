//
//  EditViewController+UITableViewDataSource.swift
//  TimeZone
//
//  Created by arosenblatt on 11/20/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//

import UIKit

extension EditViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = self.viewModel else {
            return 0
        }
        return viewModel.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EditViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        guard let viewModel = self.viewModel else {
            return cell
        }
        
        cell.viewModel = viewModel.data(for: indexPath)
        
        return cell
    }
}
