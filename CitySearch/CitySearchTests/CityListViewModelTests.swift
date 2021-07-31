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
        self.viewModel?.fetchCities()
        
        self.viewModel?.cities = { data in
            expect.fulfill()
            XCTAssertNotNil(data)
            XCTAssertEqual(data.count, 3)
        }
        self.wait(for: [expect], timeout: 1)
    }
    
    func testFetchCitiesSorting() {
        let expect = self.expectation(description: "fetch cities lists")
        self.viewModel?.fetchCities()
        
        self.viewModel?.cities = { data in
            expect.fulfill()
            XCTAssertNotNil(data)
            XCTAssertEqual(data.count, 3)
            
            XCTAssertEqual(data[0].fullAddress, "Azriqam, IL")
            XCTAssertEqual(data[1].fullAddress, "Hurzuf, UA")
            XCTAssertEqual(data[2].fullAddress, "Novinki, RU")
        }
        self.wait(for: [expect], timeout: 1)
    }

    func testFetchingOfCitiesFailedDueToWrongFileName() {
        let client = CityService(fileName: "WrongFileName", bundle: Bundle(for: Self.self))
        let viewModel = CityListViewModel(with: client)
        
        let expect = self.expectation(description: "fetch cities lists failed")
        viewModel.fetchCities()
        
        viewModel.showError = { error in
            expect.fulfill()
            XCTAssertEqual(ServiceErrors.unableToLoadFile.errorDescription, error)
        }
        self.wait(for: [expect], timeout: 1)
    }
    
    func testEmptyCitiesRecords() {
        let client = CityService(fileName: "EmptyData", bundle: Bundle(for: Self.self))
        let viewModel = CityListViewModel(with: client)
        
        let expect = self.expectation(description: "Empty cities records")
        viewModel.fetchCities()
        
        viewModel.showError = { error in
            expect.fulfill()
            XCTAssertEqual(ServiceErrors.noDataFound.errorDescription, error)
        }
        self.wait(for: [expect], timeout: 1)
    }
    
    func testSelectionOfCityAtFirstIndex() {
        
        let indexPath = IndexPath(row: 0, section: 0)
        let city = self.city()[indexPath.row]
        
        let expect = self.expectation(description: "test selection of city")
        
        self.viewModel?.citySelectionObserver = { data in
            expect.fulfill()
            
            XCTAssertEqual(data.0.latitude, 31.75)
            XCTAssertEqual(data.0.longitude, 34.700001)
            XCTAssertEqual(data.1.row, 0)
            XCTAssertEqual(data.1.section, 0)
            XCTAssertEqual(data.2, "Azriqam, IL")
        }
        
        self.viewModel?.didSelect(city, at: indexPath)
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

