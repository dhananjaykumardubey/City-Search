//
//  CityListViewModelTests.swift
//  CitySearchTests
//
//  Created by Dhananjay Dubey on 31/7/21.
//

import XCTest
@testable import CitySearch

class CityListViewModelTests: XCTestCase {
    
    private var viewModel: CityListViewModel?
    private var apiClient: APIClient!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.apiClient = CityService(fileName: "CitiesMock", bundle: Bundle(for: Self.self))
        self.viewModel = CityListViewModel(with: self.apiClient)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.viewModel = nil
        self.apiClient = nil
    }
    
    func testFetchCitiesSuccessfully() {
        let expect = self.expectation(description: "fetch cities lists")
        self.viewModel?.cities = { data in
            expect.fulfill()
            XCTAssertNotNil(data)
            XCTAssertEqual(data.count, 3)
        }
        self.viewModel?.fetchCities()
        self.wait(for: [expect], timeout: 1)
    }
    
    func testFetchCitiesSorting() {
        let expect = self.expectation(description: "fetch cities lists")
        self.viewModel?.cities = { data in
            expect.fulfill()
            XCTAssertNotNil(data)
            XCTAssertEqual(data.count, 3)
            
            XCTAssertEqual(data[0].fullAddress, "Azriqam, IL")
            XCTAssertEqual(data[1].fullAddress, "Hurzuf, UA")
            XCTAssertEqual(data[2].fullAddress, "Novinki, RU")
        }
        self.viewModel?.fetchCities()
        self.wait(for: [expect], timeout: 1)
    }

    func testFetchingOfCitiesFailedDueToWrongFileName() {
        let client = CityService(fileName: "WrongFileName", bundle: Bundle(for: Self.self))
        let viewModel = CityListViewModel(with: client)
        
        let expect = self.expectation(description: "fetch cities lists failed")
        viewModel.showError = { error in
            expect.fulfill()
            XCTAssertEqual(ServiceErrors.unableToLoadFile.errorDescription, error)
        }
        viewModel.fetchCities()
        self.wait(for: [expect], timeout: 1)
    }
    
    func testEmptyCitiesRecords() {
        let client = CityService(fileName: "EmptyData", bundle: Bundle(for: Self.self))
        let viewModel = CityListViewModel(with: client)
        
        let expect = self.expectation(description: "Empty cities records")
        viewModel.showError = { error in
            expect.fulfill()
            XCTAssertEqual(ServiceErrors.noDataFound.errorDescription, error)
        }
        viewModel.fetchCities()
        self.wait(for: [expect], timeout: 1)
    }
    
    func testSelectionOfCityAtFirstIndex() {
        
        let indexPath = IndexPath(row: 0, section: 0)
        let city = self.city()[indexPath.row]
        
        let expect = self.expectation(description: "test selection of city")
        
        self.viewModel?.citySelectionObserver = { data in
            expect.fulfill()
            
            XCTAssertEqual(data.0.latitude, 44.549999)
            XCTAssertEqual(data.0.longitude, 34.283333)
            XCTAssertEqual(data.1.row, 0)
            XCTAssertEqual(data.1.section, 0)
            XCTAssertEqual(data.2, "Hurzuf, UA")
        }
        
        self.viewModel?.didSelect(city, at: indexPath)
        self.wait(for: [expect], timeout: 1)
    }
    
    func testFailedToFindLatAndLonForSelectedCity() {
        let indexPath = IndexPath(row: 0, section: 0)
        let stubbedData = Data("""
                [
                  {
                      \"country\":\"UA\",
                       \"name\":\"Hurzuf\",
                       \"_id\": 707860
                },
                 {
                                      \"country\":\"RU\",
                                       \"name\":\"Novinki\",
                                       \"_id\": 519188,
                                       \"coord\": {
                                           \"lon\": 37.666668,
                                           \"lat\": 55.683334
                                
                                 }
                                },
                                  {
                                      \"country\":\"IL\",
                                       \"name\":\"Azriqam\",
                                       \"_id\": 295582,
                                       \"coord\": {
                                           \"lon\": 34.700001,
                                           \"lat\": 31.75
                                
                                 }
                                }
                ]
                """.utf8)
        guard
            let cities = try? JSONDecoder().decode(Cities.self, from: stubbedData)
            else {
            XCTFail()
            return
        }
        let city = cities[indexPath.row]
        
        let expect = self.expectation(description: "test selection of city")
        expect.isInverted = true
        self.viewModel?.citySelectionObserver = { data in
            expect.fulfill()
        }
        
        let errorExpect = self.expectation(description: "expect error for no location")
        self.viewModel?.showError = { error in
            errorExpect.fulfill()
            XCTAssertEqual(error, "No Location Found")
        }
        
        self.viewModel?.didSelect(city, at: indexPath)
        self.wait(for: [expect, errorExpect], timeout: 1)
    }
    
    func testSearchForEmptyString() {
        let expect = self.expectation(description: "test search for empty string")
       
        let viewModel = CityListViewModel(with: self.city())
        
        viewModel.cities = { data in
            expect.fulfill()
            XCTAssertEqual(data.count, 3)
            XCTAssertEqual(data[0].fullAddress, "Azriqam, IL")
            XCTAssertEqual(data[1].fullAddress, "Hurzuf, UA")
            XCTAssertEqual(data[2].fullAddress, "Novinki, RU")
        }
        
        viewModel.search(for: "")
        self.wait(for: [expect], timeout: 1)
    }

    func testSuccessfullSearchForText() {
        guard let cities = try? parse(toType: Cities.self, data: Stubbed.searchCityStubbedData)
        else {
            XCTFail()
            return
        }
        let expect = self.expectation(description: "test search for input string")
        XCTAssertNotNil(cities)
        XCTAssertEqual(cities.count, 15)
       
        let viewModel = CityListViewModel(with: cities)
        
        viewModel.cities = { data in
            expect.fulfill()
            XCTAssertEqual(data.count, 2)
            XCTAssertEqual(data[0].fullAddress, "Bangalore, IN")
            XCTAssertEqual(data[1].fullAddress, "Bangalow, AU")
        }
        
        viewModel.search(for: "Bang")
        self.wait(for: [expect], timeout: 1)
    }
    
    private func city() -> [City] {
        
        let stubbedData = Data("""
                [
                  {
                      \"country\":\"UA\",
                       \"name\":\"Hurzuf\",
                       \"_id\": 707860,
                       \"coord\": {
                           \"lon\": 34.283333,
                           \"lat\": 44.549999
                
                 }
                },
                 {
                                      \"country\":\"RU\",
                                       \"name\":\"Novinki\",
                                       \"_id\": 519188,
                                       \"coord\": {
                                           \"lon\": 37.666668,
                                           \"lat\": 55.683334
                                
                                 }
                                },
                                  {
                                      \"country\":\"IL\",
                                       \"name\":\"Azriqam\",
                                       \"_id\": 295582,
                                       \"coord\": {
                                           \"lon\": 34.700001,
                                           \"lat\": 31.75
                                
                                 }
                                }
                ]
                """.utf8)
        guard
            let cities = try? JSONDecoder().decode(Cities.self, from: stubbedData)
            else {
            return []
        }
        return cities
    }
}

