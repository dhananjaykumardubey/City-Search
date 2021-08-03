//
//  ServiceErrors.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 29/7/21.
//

import Foundation

/// This can be extended to handle all the various types, like network erros, request/response errors
enum ServiceErrors: Error {
    
    /// Error thrown when parsing fails for model
    case unableToParseData
    
    /// Error thrown when file name (which needs to be loaded) is wrong or file not found in bundle
    case unableToLoadFile
    
    /// Error thrown loaded file is having corruped content and not able to convert it into data
    case dataCorrupted
    
    /// Error thrown when file is empty and the result tends to empty data
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
