//
//  CityListDataSourceTests.swift
//  CitySearchTests
//
//  Created by Dhananjay Kumar Dubey on 1/8/21.
//

import XCTest
@testable import CitySearch

class CityListDataSourceTests: XCTestCase {

    private var cityList: Cities?
    let tableView = UITableView()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        guard let cities = try? parse(toType: Cities.self, data: Stubbed.searchCityStubbedData)
        else {
            XCTFail()
            return
        }
        self.cityList = cities
        XCTAssertEqual(self.cityList?.count, 15)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.estimatedRowHeight = 44
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.cityList = nil
    }
    
    func testHasZeroSectionsWhenEmptyCities() {
        let dataSource = CityListDataSource(with: [])
            XCTAssertEqual(dataSource.numberOfSections(in: tableView), 0)
    }
    
    func testHasOneSectionsWhenCitiesArePresent() {
        let dataSource = CityListDataSource(with: self.cityList ?? [])
            XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1)
    }
    
    func testNumberOfRows() {
        let tableView = UITableView()
        let dataSource = CityListDataSource(with: self.cityList ?? [])
        let numberOfRows = dataSource.tableView(tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 15,
                       "Number of rows in table should match number of cities")
    }
    
    func testCellForRow() {
        let dataSource = CityListDataSource(with: self.cityList ?? [])
        self.tableView.register(nib: .CityCell)
        guard let cell = dataSource.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? CityCell else { return }
        XCTAssertEqual(cell.titleLabel.text, "Alfafara, ES")
    }
    
    func testCityAtCorrectIndexPath() {
        let dataSource = CityListDataSource(with: self.cityList ?? [])
        
        guard let city = dataSource.city(at: IndexPath(row: 5, section: 0))
        else {
            XCTFail()
            return
        }
        XCTAssertEqual(city.id, 2521131)
        XCTAssertEqual(city.fullAddress, "Benamaurel, ES")
    }
    
    func testEmptyCityAtCorrectIndexPath() {
        let dataSource = CityListDataSource(with: [])
        let city = dataSource.city(at: IndexPath(row: 0, section: 0))
        XCTAssertNil(city)
    }
}
