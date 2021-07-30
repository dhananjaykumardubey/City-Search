//
//  APIClient.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 30/7/21.
//

import Foundation

protocol APIClient {

    init(fileName: String, bundle: Bundle)

    func fetchCities(_ completion: @escaping ((Result<Cities, Error>) -> Void))
}
