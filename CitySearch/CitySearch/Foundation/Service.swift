//
//  Service.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 29/7/21.
//

import Foundation

protocol Service: Loadable {
    associatedtype Response: Decodable
    
    func execute(for fileName: String,
                 in bundle: Bundle,
                 then completion: @escaping ((Result<Response, Error>) -> Void))
}

extension Service {
    func execute(for fileName: String,
                 in bundle: Bundle,
                 then completion: @escaping ((Result<Response, Error>) -> Void)) {
        
        guard let result = try? self.loadLocalFile(for: fileName, from: bundle) else {
            completion(.failure(ServiceErrors.unableToLoadFile))
            return
        }
        switch result {
        case .success( let data):
            do {
                let result = try parse(toType: Response.self, data: data)
                completion(.success(result))
            } catch {
                print("Errors \(error)")
                completion(.failure(ServiceErrors.unableToParseData))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
