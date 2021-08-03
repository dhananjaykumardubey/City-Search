//
//  Service.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 29/7/21.
//

import Foundation

protocol Service: Loadable {
    
    /// generic type confirming to Decodable model to which the data will be parsed
    associatedtype Response: Decodable
    
    /**
     Loads the file from bundle, and parse it into required Model
     - parameters:
        - fileName: Filename, which needs to be loaded
        - bundle: Bundle from where this file needs to be loaded.
        - completion: On completion, it returns with Result type with the Model of type `Response` or error as `ServiceErrors`
     */
    func execute(for fileName: String,
                 in bundle: Bundle,
                 then completion: @escaping ((Result<Response, ServiceErrors>) -> Void))
}

extension Service {
    
    func execute(for fileName: String,
                 in bundle: Bundle,
                 then completion: @escaping ((Result<Response, ServiceErrors>) -> Void)) {
        let result = self.loadLocalFile(for: fileName, from: bundle)
        switch result {
        case .success(let data):
            do {
                guard let data = data else {
                    completion(.failure(ServiceErrors.dataCorrupted))
                    return
                }
                let result = try parse(toType: Response.self, data: data)
                completion(.success(result))
            } catch {
                completion(.failure(ServiceErrors.unableToParseData))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
