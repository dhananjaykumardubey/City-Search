//
//  Parser.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 29/7/21.
//

import Foundation

/**
 Parse the data into expected Model
 - parameters:
    - T: Generic type model, in which the data needs to be parsed into
    - data: Data which needs to be parsed
    - returns: returns the parsed Model of type T
  throws error as `UnableToParse` if parsing fails due to corrupt data
 */
func parse<T: Decodable>(toType: T.Type, data: Data) throws -> T {
    do {
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    } catch {
        throw ServiceErrors.unableToParseData
    }
}
