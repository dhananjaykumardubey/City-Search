//
//  CitiesTests.swift
//  CitySearchTests
//
//  Created by Dhananjay Dubey on 30/7/21.
//

import XCTest
@testable import CitySearch

class CitiesTests: XCTestCase {

    private var cities: Cities?
    
    override func setUpWithError() throws {
        do {
            self.cities = try parse(toType: Cities.self, data: Stubbed.successStubbedData)
            XCTAssertNotNil(self.cities)
            XCTAssertEqual(self.cities?.count, 1)
        } catch {
            XCTFail()
        }
    }
    
    override func tearDownWithError() throws {
        self.cities = nil
    }
    
    func testSuccessfulParsing() {
        guard
            let cities = self.cities,
            let city = cities.first
        else {
            XCTFail("cities not found")
            return
        }
        XCTAssertEqual(cities.count, 1)
        XCTAssertEqual(city.city, "Hurzuf")
        XCTAssertEqual(city.country, "UA")
        XCTAssertEqual(city.id, 707860)
        XCTAssertEqual(city.coordinates?.lat, 44.549999)
        XCTAssertEqual(city.coordinates?.lon, 34.283333)
        XCTAssertEqual(city.fullAddress, "Hurzuf, UA")
    }
    
    func testFullAddressWithCityAndCountry() {
        
        let stubbedData = Data("""
                [
                  {
                      \"country\":\"UA\",
                       \"name\":\"Hurzuf\",
                }
                ]
                """.utf8)
        guard
            let cities = try? parse(toType: Cities.self, data: stubbedData),
            let city = cities.first
        else {
            XCTFail("cities not found")
            return
        }
        XCTAssertEqual(city.fullAddress, "Hurzuf, UA")
    }
    
    func testFullAddressWithCityAndWithoutCountry() {
        
        let stubbedData = Data("""
                [
                  {
                       \"name\":\"Hurzuf\"
                }
                ]
                """.utf8)
        guard
            let cities = try? parse(toType: Cities.self, data: stubbedData),
            let city = cities.first
        else {
            XCTFail("cities not found")
            return
        }
        XCTAssertEqual(city.fullAddress, "Hurzuf")
    }
    
    func testFullAddressWithoutCityAndWithCountry() {
        
        let stubbedData = Data("""
                [
                  {
                      \"country\":\"UA\"
                }
                ]
                """.utf8)
        guard
            let cities = try? parse(toType: Cities.self, data: stubbedData),
            let city = cities.first
        else {
            XCTFail("cities not found")
            return
        }
        XCTAssertEqual(city.fullAddress, "UA")
    }
    
    func testParsingFailure() {
        XCTAssertThrowsError(try parse(toType: Cities.self, data: Stubbed.failureStubbedData)) { error in
            XCTAssertEqual(error as? ServiceErrors, ServiceErrors.unableToParseData)
        }
    }
}
