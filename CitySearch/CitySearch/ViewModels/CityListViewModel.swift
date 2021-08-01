//
//  CityListViewModel.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 30/7/21.
//

import Foundation
import UIKit
import CoreLocation

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
    
    /// Callback to send out location of city when city is selected
    var citySelectionObserver: (((CLLocationCoordinate2D, IndexPath, String)) -> Void)?

    //MARK: Private properties
    private let apiClient: APIClient?
    private lazy var cityList: [City] = []
    private var searchManager: SearchManager?
    
    init(with apiClient: APIClient?) {
        self.apiClient = apiClient
    }
    
    convenience init(with cities: Cities) {
        self.init(with: nil)
        self.cityList = sortOnCity(cities)
        self.searchManager = SearchManager(with: self.cityList)
    }
    
    /// BindViewModel call to let viewmodel know that bindViewModel of viewcontroller is called and completed and properties can be observed
    func bindViewModel() {
        self.fetchCities()
    }
    
    /// Fetch cities from local file
    func fetchCities() {
        self.startLoading?()
        DispatchQueue.global(qos: .userInteractive).async {
            self.apiClient?.fetchCities({ [weak self] response in
                performOnMain {
                    self?.endLoading?()
                    guard let _self = self else {
                        return
                    }
                    switch response {
                    case let .success(cities):
                        if !cities.isEmpty {
                            let sortedCities = sortOnCity(cities)
                            _self.cityList = sortedCities
                            _self.searchManager = SearchManager(with: sortedCities)
                            _self.cities?(sortedCities)
                        } else {
                            _self.showError?(ServiceErrors.noDataFound.errorDescription)
                        }
                    case let .failure(error):
                        _self.endLoading?()
                        _self.showError?(error.errorDescription)
                    }
                }
            })
        }
    }
    
    func didSelect(_ city: City, at indexPath: IndexPath) {
        guard let lat = city.coordinates?.lat,
              let lon = city.coordinates?.lon
        else {
            self.showError?("No Location Found")
            return
        }
        self.citySelectionObserver?((CLLocationCoordinate2D(latitude: lat, longitude: lon), indexPath, city.fullAddress))
    }

    func search(for text: String) {
        if text.isEmpty {
            self.cities?(self.cityList)
        } else {
            self.cities?(self.searchManager?.search(for: text.lowercased()) ?? [])
        }
    }
}

fileprivate func sortOnCity(_ cities: Cities) -> Cities {
    return cities.sorted { lhs, rhs in
        return (lhs.city ?? "") < (rhs.city ?? "")
    }
}
