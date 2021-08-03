//
//  UITableView+Enhancements.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 31/7/21.
//

import UIKit

extension UITableView {
    
    /// Register a cell nib from bundle to display it on table view
    func register(nib: Nib, inBundle bundle: Bundle = .main) {
        self.register(UINib(nibName: nib.rawValue, bundle: bundle), forCellReuseIdentifier: nib.rawValue)
    }
    
    /// Checks if there is a valid row at given indexPath
    func hasRow(at indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
}
