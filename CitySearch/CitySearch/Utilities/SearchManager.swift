//
//  SearchManager.swift
//  CitySearch
//
//  Created by Dhananjay Kumar Dubey on 1/8/21.
//

import Foundation

/**
 This `SearchManager` is implemented by using the concept of Binary Search.
 Since we wanted to avoid Linear time complexity, because of very large dataset. Having a linear search by using `filter` or `contains`, will potentially take us to O(n), where n is the size of dataset.
 
 I had few approach to do this:
 
 `Approach - 1`
 Working with array data structure, left me with option of `Binary Search Algorithm` which gives us logarithmic time complexity
 
 */
class SearchManager {

    private var cities: [City]
    private var filterStart: Int
    private var filterEnd: Int

    init(with cities: Cities) {
        self.cities = cities
        filterStart = 0
        filterEnd = cities.count - 1
    }
    
    func search(for text: String) -> Cities {
        self.filterStart = binarySearchFirst(array: self.cities, target: text)
        self.filterEnd = binarySearchLast(array: self.cities, target: text)
        if filterStart == -1 || filterEnd == -1 { return [] }
        return Array(self.cities[filterStart...filterEnd])
    }
    
    private func binarySearchLast(array: [City], target: String) -> Int {
        var left = 0
        var right = array.count - 1

        while (left <= right) {
            let mid = left + ((right - left) / 2)
            let value = array[mid]
            guard let city = value.city?.lowercased() else { return -1 }
            
            if (left == right && city.hasPrefix(target)) {
                return left
            }

            if city.hasPrefix(target) {
                if mid < array.count - 1 {
                    if !(array[mid + 1].city?.lowercased().hasPrefix(target) ?? true) {
                        return mid
                    }
                }

                left = mid + 1
            } else if (city <= target) {
                left = mid + 1
            } else if (city >= target) {
                right = mid - 1
            }
        }

        return -1
    }

    private func binarySearchFirst(array: [City], target: String) -> Int {
        var left = 0
        var right = array.count - 1

        while (left <= right) {
            let mid = left + ((right - left) / 2)
            let value = array[mid]
            guard let city = value.city?.lowercased() else { return -1 }
            if (left == right && city.hasPrefix(target)) {
                return left
            }

            if city.hasPrefix(target) {
                if mid > 0 {
                    if !(array[mid - 1].city?.lowercased().hasPrefix(target) ?? true) {
                        return mid
                    }
                }
                right = mid - 1
            } else if (city <= target) {
                left = mid + 1
            } else if (city >= target) {
                right = mid - 1
            }
        }
        return -1
    }
}
