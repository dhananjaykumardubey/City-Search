//
//  APIClient.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 30/7/21.
//

import Foundation

protocol APIClient {

    /**
     Initializes the client with `filename` and `bundle`name, from where the data needs to be loaded
     - parameters:
        - fileName: Name of Json file from where data needs to be loaded
        - bundle: Bundle where this file is located
        - returns: City found at the indexPath, if not found then returns nil
     */
    init(fileName: String, bundle: Bundle)
    
    /// Fetch cities for given path and on completion returns the response in terms of Result type.
    func fetchCities(_ completion: @escaping ((Result<Cities, ServiceErrors>) -> Void))
}
