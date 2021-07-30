//
//  Nib.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 30/7/21.
//

import UIKit

enum Nib: String {
    case CityCell
}

extension UITableView {
    func register(nib: Nib, inBundle bundle: Bundle = .main) {
        self.register(UINib(nibName: nib.rawValue, bundle: bundle), forCellReuseIdentifier: nib.rawValue)
    }
}
