//
//  Loadable.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 29/7/21.
//

import Foundation

/// Protocol to load file from app bundle
/// this can be extended further for API calls and scaling up for actual network layer
protocol Loadable {
    
    /**
     Loads the file from bundle, converts it into a Data format
     - parameters:
        - name: Filename, which needs to be loaded
        - bundle: bundle from where this file needs to be loaded.
        - returns: Response in terms of Result type
     */
    func loadLocalFile(for name: String,
                       from bundle: Bundle) -> Result<Data?, ServiceErrors>
}

extension Loadable {
    func loadLocalFile(for name: String,
                       from bundle: Bundle) -> Result<Data?, ServiceErrors> {
        do {
            guard
                let bundlePath = bundle.path(forResource: name, ofType: "json") else {
                return .failure(ServiceErrors.unableToLoadFile)
            }
            let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8)
            return .success(jsonData)
        } catch {
            return .failure(ServiceErrors.dataCorrupted)
        }
    }
}

