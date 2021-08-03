//
//  CityListDataSource.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 30/7/21.
//

import UIKit

class CityListDataSource: NSObject, UITableViewDataSource {
    
    private var cities: [City]
    
    /**
     Initializes `CityListDataSource` with provided cities, to be displayed in table view
     
     - parameters:
        - data: datasource of cities
     */
    init(with cities: [City]) {
        self.cities = cities
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.cities.isEmpty ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Nib.CityCell.rawValue, for: indexPath) as? CityCell
        else { return UITableViewCell() }
        cell.configure(with: self.cities[indexPath.row])
        return cell
    }
}

extension CityListDataSource {
    
    /**
     Returns the city at asked indexPath. Triggered from didSelectRow, delegate method of tableView
     - parameters:
        - indexPath: The requested indexPath
        - returns: City found at the indexPath, if not found then returns nil
     */
    func city(at indexPath: IndexPath) -> City? {
        guard !self.cities.isEmpty,
              self.cities.count > indexPath.row
        else { return nil }
        return self.cities[indexPath.row]
    }
}
