//
//  SearchManagerTests.swift
//  CitySearchTests
//
//  Created by Dhananjay Kumar Dubey on 1/8/21.
//

import XCTest
@testable import CitySearch

class SearchManagerTests: XCTestCase {

    private var cities: [City] = []
    
    func loadCitiesFromBundle() {
        do {
            guard
                let bundlePath = Bundle.main.path(forResource: "cities", ofType: "json"),
                let jsonData = try? String(contentsOfFile: bundlePath).data(using: .utf8),
                let result = try? parse(toType: Cities.self, data: jsonData)
            else {
                return
            }
            self.cities = result
        }
    }

}

