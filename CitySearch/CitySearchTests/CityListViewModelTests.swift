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

}
