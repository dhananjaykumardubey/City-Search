//
//  Loadable.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 29/7/21.
//

import Foundation

/// Protocol to load file from app bundle, this can be extended further for API calls and scaling up for actual network layer
protocol Loadable {
    // TODO: Write document
    func loadLocalFile(for name: String,
                       from bundle: Bundle) throws -> Result<Data, Error>
}

extension Loadable {
    func loadLocalFile(for name: String,
                       from bundle: Bundle) throws -> Result<Data, Error> {
        do {
            guard
                let bundlePath = bundle.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) else {
                return .failure(ServiceErrors.unableToLoadFile)
            }
            return .success(jsonData)
        } catch {
            throw ServiceErrors.dataCorrupted
        }
    }
}

