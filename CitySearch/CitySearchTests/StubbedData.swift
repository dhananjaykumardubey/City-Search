//
//  StubbedData.swift
//  CitySearchTests
//
//  Created by Dhananjay Dubey on 30/7/21.
//

import Foundation

struct Stubbed {
    static let successStubbedData = Data("""
            [
              {
                  \"country\":\"UA\",
                   \"name\":\"Hurzuf\",
                   \"_id\":707860,
                   \"coord\": {
                       \"lon\":34.283333,
                       \"lat\":44.549999
            
             }
            }
            ]
            """.utf8)
    
    static let failureStubbedData = Data("""
                        [
                          {
                              \"country\":\"UA\",
                               \"name\":\"Hurzuf\",
                               \"_id\":707860,
                               \"coord\": {
                                   \"lon\": "34.283333",
                                   \"lat\": "44.549999"
                        
                         }
                        }
                        ]
            """.utf8)
}
