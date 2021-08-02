//
//  SearchManagerTests.swift
//  CitySearchTests
//
//  Created by Dhananjay Kumar Dubey on 1/8/21.
//

import XCTest
@testable import CitySearch

class SearchManagerTests: XCTestCase {

    private var searchManager: SearchManager?
    
    func loadCitiesFromStubbed() -> Cities {
        guard let cities = try? parse(toType: Cities.self, data: Stubbed.searchCityStubbedData)
        else {
            return []
        }
        return cities.sortOnCity()
    }

    override func setUpWithError() throws {
        self.searchManager = SearchManager(with: self.loadCitiesFromStubbed())
    }
    
    override func tearDownWithError() throws {
        self.searchManager = nil
    }
    
    func testSearchOnEmptyCityList() {
        let searchManager = SearchManager(with: [])
        let cities = searchManager.search(for: "Alf")
        XCTAssertEqual(cities, [])
    }
    
    func testSearchForSingleCharacter() {
        let cities = self.searchManager?.search(for: "B")
        XCTAssertNotNil(cities)
        XCTAssertEqual(cities?.count, 12)
        XCTAssertEqual(cities?[0].fullAddress, "Baluburlimbangan, ID")
        XCTAssertEqual(cities?[1].fullAddress, "Bangalore, IN")
        XCTAssertEqual(cities?[2].fullAddress, "Bangalow, AU")
        XCTAssertEqual(cities?[3].fullAddress, "Bebandem, ID")
        XCTAssertEqual(cities?[4].fullAddress, "Belopa, ID")
        XCTAssertEqual(cities?[5].fullAddress, "Benamargosa, ES")
        XCTAssertEqual(cities?[6].fullAddress, "Benamaurel, ES")
        XCTAssertEqual(cities?[7].fullAddress, "Benamocarra, ES")
        XCTAssertEqual(cities?[8].fullAddress, "Benaocaz, ES")
        XCTAssertEqual(cities?[9].fullAddress, "Biha, ID")
        XCTAssertEqual(cities?[10].fullAddress, "Bilungala, ID")
        XCTAssertEqual(cities?[11].fullAddress, "Binangun, ID")
    }
    
    func testSearchForDoubleCharacter() {
        let cities = self.searchManager?.search(for: "Be")
        XCTAssertNotNil(cities)
        XCTAssertEqual(cities?.count, 6)
        XCTAssertEqual(cities?[0].fullAddress, "Bebandem, ID")
        XCTAssertEqual(cities?[1].fullAddress, "Belopa, ID")
        XCTAssertEqual(cities?[2].fullAddress, "Benamargosa, ES")
        XCTAssertEqual(cities?[3].fullAddress, "Benamaurel, ES")
        XCTAssertEqual(cities?[4].fullAddress, "Benamocarra, ES")
        XCTAssertEqual(cities?[5].fullAddress, "Benaocaz, ES")
    }
    
    func testSearchForThreeCharacterSingleResult() {
        let cities = self.searchManager?.search(for: "Bel")
        XCTAssertNotNil(cities)
        XCTAssertEqual(cities?.count, 1)
        XCTAssertEqual(cities?[0].fullAddress, "Belopa, ID")
    }
    
    func testSearchForThreeCharacterMultipleResult() {
        let cities = self.searchManager?.search(for: "Ben")
        XCTAssertNotNil(cities)
        XCTAssertEqual(cities?.count, 4)
        XCTAssertEqual(cities?[0].fullAddress, "Benamargosa, ES")
        XCTAssertEqual(cities?[1].fullAddress, "Benamaurel, ES")
        XCTAssertEqual(cities?[2].fullAddress, "Benamocarra, ES")
        XCTAssertEqual(cities?[3].fullAddress, "Benaocaz, ES")
    }
    
    func testSearchForMultipleCharacterMultipleResult() {
        let cities = self.searchManager?.search(for: "Benam")
        XCTAssertNotNil(cities)
        XCTAssertEqual(cities?.count, 3)
        XCTAssertEqual(cities?[0].fullAddress, "Benamargosa, ES")
        XCTAssertEqual(cities?[1].fullAddress, "Benamaurel, ES")
        XCTAssertEqual(cities?[2].fullAddress, "Benamocarra, ES")
    }
    
    func testSearchForMultipleCharacterWithOnly2Results() {
        let cities = self.searchManager?.search(for: "Benama")
        XCTAssertNotNil(cities)
        XCTAssertEqual(cities?.count, 2)
        XCTAssertEqual(cities?[0].fullAddress, "Benamargosa, ES")
        XCTAssertEqual(cities?[1].fullAddress, "Benamaurel, ES")
    }
    
    func testSearchForMultipleCharacterWithSingleResult() {
        let cities = self.searchManager?.search(for: "Benamar")
        XCTAssertNotNil(cities)
        XCTAssertEqual(cities?.count, 1)
        XCTAssertEqual(cities?[0].fullAddress, "Benamargosa, ES")
    }
    
    func testSearchForTextWithNoResult() {
        let cities = self.searchManager?.search(for: "egewrgergqr")
        XCTAssertNotNil(cities)
        XCTAssertEqual(cities?.count, 0)
    }
    
    func testSearchForEmptyText() {
        let cities = self.searchManager?.search(for: "")
        XCTAssertNotNil(cities)
        XCTAssertEqual(cities?.count, 15)
        
        XCTAssertEqual(cities?[0].fullAddress, "Aldeire, ES")
        XCTAssertEqual(cities?[1].fullAddress, "Alfacar, ES")
        XCTAssertEqual(cities?[2].fullAddress, "Alfafara, ES")
        XCTAssertEqual(cities?[3].fullAddress, "Baluburlimbangan, ID")
        XCTAssertEqual(cities?[4].fullAddress, "Bangalore, IN")
        XCTAssertEqual(cities?[5].fullAddress, "Bangalow, AU")
        XCTAssertEqual(cities?[6].fullAddress, "Bebandem, ID")
        XCTAssertEqual(cities?[7].fullAddress, "Belopa, ID")
        XCTAssertEqual(cities?[8].fullAddress, "Benamargosa, ES")
        XCTAssertEqual(cities?[9].fullAddress, "Benamaurel, ES")
        XCTAssertEqual(cities?[10].fullAddress, "Benamocarra, ES")
        XCTAssertEqual(cities?[11].fullAddress, "Benaocaz, ES")
        XCTAssertEqual(cities?[12].fullAddress, "Biha, ID")
        XCTAssertEqual(cities?[13].fullAddress, "Bilungala, ID")
        XCTAssertEqual(cities?[14].fullAddress, "Binangun, ID")
    }
}
