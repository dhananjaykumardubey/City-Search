//
//  CityService.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 29/7/21.
//

import Foundation

protocol LocalCitiesClient {

    init(fileName: String, bundle: Bundle)

    func fetchCities(_ completion: @escaping ((Result<Cities, Error>) -> Void))
}

final class CityService: LocalCitiesClient, Service {

    typealias Response = Cities
    
    private lazy var fileName: String = ""
    private lazy var bundle: Bundle = .main
    
    init(fileName: String, bundle: Bundle) {
        self.fileName = fileName
        self.bundle = bundle
    }
    
    func fetchCities(_ completion: @escaping ((Result<Cities, Error>) -> Void)) {
        self.execute(for: self.fileName, in: self.bundle, then: completion)
    }
}
