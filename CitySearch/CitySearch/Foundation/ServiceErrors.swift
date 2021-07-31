//
//  ServiceErrors.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 29/7/21.
//

import Foundation

/// This can be extended to handle all the various types, like network erros, request/response errors
enum ServiceErrors: Error {
    
    case unableToParseData
    case unableToLoadFile
    case dataCorrupted
    case noDataFound
    
    var errorDescription: String {
        switch self {
        case .unableToParseData:
            return "Parser Error - Something went wrong.\n Please try again later"
        case .unableToLoadFile:
            return "Loading Error - Unable to load the file from bundle"
        case .dataCorrupted:
            return "Data Error - Unable to load data from file, as data looks corrupted"
        case .noDataFound:
            return "No data found. \n Please try again later"
        }
    }
}
