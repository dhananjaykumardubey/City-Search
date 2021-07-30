//
//  CityListViewModel.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 30/7/21.
//

import Foundation
import UIKit

final class CityListViewModel {
    
    // MARK: Callbacks or observers
    
    /// Callback for showing loader
    var startLoading: (() -> Void)?
    
    /// Callback for removing the loader
    var endLoading: (() -> Void)?
    
    /// Callback for showing the error message
    var showError: ((String) -> Void)?
    
    /// Callback returning cities as datasource
    var cities: (([City]) -> Void)?
    
    //MARK: Private properties
    private let apiClient: APIClient?
    
    required init(with apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    /// BindViewModel call to let viewmodel know that bindViewModel of viewcontroller is called and completed and properties can be observed
    func bindViewModel() {
        self.fetchCities()
    }
    
    /// Fetch cities from local file
    func fetchCities() {
        self.startLoading?()
        DispatchQueue.global(qos: .userInitiated).async {
            self.apiClient?.fetchCities({ [weak self] response in
                performOnMain {
                    self?.endLoading?()
                    guard let _self = self else {
                        return
                    }
                    switch response {
                    case let .success(cities):
                        if !cities.isEmpty {
                            let sortedCities = cities.sorted { lhs, rhs in
                                return (lhs.city ?? "") < (rhs.city ?? "")
                            }
                            _self.cities?(sortedCities)
                        } else {
                            _self.showError?(ServiceErrors.noDataFound.errorDescription ?? "")
                        }
                    case let .failure(error):
                        _self.endLoading?()
                        _self.showError?(error.localizedDescription)
                    }
                }
            })
        }
    }
}
