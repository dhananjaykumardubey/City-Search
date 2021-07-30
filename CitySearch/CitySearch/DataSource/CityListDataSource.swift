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
     Initializes `CityListDataSource` with provided exchange rate data, to be displayed in collection view
     
     - parameters:
     - data: datasource of exchange rate data
     */
    init(with cities: [City]) {
        self.cities = cities
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
    func city(at indexPath: IndexPath) -> City? {
        guard !self.cities.isEmpty,
              self.cities.count > indexPath.row
        else { return nil }
        return self.cities[indexPath.row]
    }
}
