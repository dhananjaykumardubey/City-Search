//
//  CityService.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 29/7/21.
//

import Foundation

/// City service class confirming to APIClient and Service protocols
/// This is the outer layer or top most layer, which will be used to fetch the cities from presentation layer
final class CityService: APIClient, Service {

    typealias Response = Cities
    
    private lazy var fileName: String = ""
    private lazy var bundle: Bundle = .main
    
    init(fileName: String, bundle: Bundle) {
        self.fileName = fileName
        self.bundle = bundle
    }
    
    func fetchCities(_ completion: @escaping ((Result<Cities, ServiceErrors>) -> Void)) {
        self.execute(for: self.fileName, in: self.bundle, then: completion)
    }
}
