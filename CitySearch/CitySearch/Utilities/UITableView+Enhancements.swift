//
//  UITableView+Enhancements.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 31/7/21.
//

import UIKit

extension UITableView {
    func register(nib: Nib, inBundle bundle: Bundle = .main) {
        self.register(UINib(nibName: nib.rawValue, bundle: bundle), forCellReuseIdentifier: nib.rawValue)
    }
    
    func hasRow(at indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
}
