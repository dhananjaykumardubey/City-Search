//
//  CityServiceTests.swift
//  CitySearchTests
//
//  Created by Dhananjay Dubey on 30/7/21.
//

import XCTest
@testable import CitySearch

class CityServiceTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCitiesFetchingSuccessfully() {
        
        let client = CityService(fileName: "CitiesMock", bundle: Bundle(for: Self.self))
        let expect = self.expectation(description: "cities list fetch")
        
        client.fetchCities({ result in
            expect.fulfill()
            do {
                let successResponse = try result.get()
                XCTAssertNotNil(successResponse)
                guard successResponse.count == 3 else {
                    XCTFail("cities not found")
                    return
                }
                
                XCTAssertEqual(successResponse[0].city, "Hurzuf")
                XCTAssertEqual(successResponse[0].country, "UA")
                XCTAssertEqual(successResponse[0].id, 707860)
                XCTAssertEqual(successResponse[0].coordinates?.lat, 44.549999)
                XCTAssertEqual(successResponse[0].coordinates?.lon, 34.283333)
                XCTAssertEqual(successResponse[0].fullAddress, "Hurzuf, UA")
                
                XCTAssertEqual(successResponse[1].city, "Novinki")
                XCTAssertEqual(successResponse[1].country, "RU")
                XCTAssertEqual(successResponse[1].id, 519188)
                XCTAssertEqual(successResponse[1].coordinates?.lat, 55.683334)
                XCTAssertEqual(successResponse[1].coordinates?.lon, 37.666668)
                XCTAssertEqual(successResponse[1].fullAddress, "Novinki, RU")
            } catch {
                XCTFail()
            }
        })
        self.wait(for: [expect], timeout: 1)
    }
    
    func testUnableToLoadFileErrorDueToWrongFileName() {
        let client = CityService(fileName: "WrongFileName", bundle: Bundle(for: Self.self))
        let expect = self.expectation(description: "Wrong file name")
        
        client.fetchCities({ result in
            expect.fulfill()
            do {
                let failureResponse = try? result.get()
                XCTAssertNil(failureResponse)
            }
            let errorResponse = result.mapError { e in ServiceErrors.unableToLoadFile }
            if case let Result.failure(error) = errorResponse {
                XCTAssertNotNil(error)
                XCTAssertEqual(ServiceErrors.unableToLoadFile.errorDescription, error.errorDescription)
            }
        })
        self.wait(for: [expect], timeout: 1)
    }
    
    func testDataCorruptedWhileLoadingFile() {
        let client = CityService(fileName: "CitiesWrongDataMock", bundle: Bundle(for: Self.self))
        let expect = self.expectation(description: "Cities Wrong Data Mock")
        
        client.fetchCities({ result in
            expect.fulfill()
            do {
                let failureResponse = try? result.get()
                XCTAssertNil(failureResponse)
            }
            let errorResponse = result.mapError { e in ServiceErrors.unableToParseData }
            if case let .failure(error) = errorResponse {
                XCTAssertNotNil(error)
                XCTAssertEqual(ServiceErrors.unableToParseData.errorDescription, error.errorDescription)
            }
        })
        self.wait(for: [expect], timeout: 1)
    }
}
