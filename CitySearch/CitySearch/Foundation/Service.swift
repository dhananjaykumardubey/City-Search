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
