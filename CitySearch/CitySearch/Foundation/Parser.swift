//
//  Parser.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 29/7/21.
//

import Foundation

func parse<T: Decodable>(toType: T.Type, data: Data) throws -> T {
    do {
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    } catch {
        throw ServiceErrors.unableToParseData
    }
}
