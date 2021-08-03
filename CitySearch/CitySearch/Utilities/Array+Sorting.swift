//
//  Array+Sorting.swift
//  CitySearch
//
//  Created by Dhananjay Kumar Dubey on 2/8/21.
//

import Foundation

extension Array where Element == City {
    
    /// Sort the array on the basis of City in ascending order
    func sortOnCity() -> [Element] {
        return self.sorted { lhs, rhs in
            return (lhs.city ?? "") < (rhs.city ?? "")
        }
    }
}
