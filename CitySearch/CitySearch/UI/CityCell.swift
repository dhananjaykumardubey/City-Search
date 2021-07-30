//
//  CityCell.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 30/7/21.
//

import UIKit

final class CityCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    /**
     Configure cell with city data
     - parameters:
     - data: city  data
     */
    func configure(with data: City) {
       
        self.titleLabel.text = data.fullAddress
        self.subtitleLabel.text = "\(data.coordinates?.lat ?? 0.0), \(data.coordinates?.lon ?? 0.0)"
        self.layoutIfNeeded()
    }
}
