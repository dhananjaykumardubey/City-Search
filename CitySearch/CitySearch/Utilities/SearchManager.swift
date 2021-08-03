//
//  SearchManager.swift
//  CitySearch
//
//  Created by Dhananjay Kumar Dubey on 1/8/21.
//

import Foundation

/**
 Since we wanted to avoid Linear time complexity, because of very large dataset.
 Having a linear search by using `filter` or `contains`, will potentially take us to O(n), where n is the size of dataset.
 
 I had few approach to do this:
 
 `Approach - 1`
 Working with array data structure, left me with option of `Binary Search Algorithm` which gives us logarithmic time complexity O(logN), and it gave me flexibilty of not using any other represenation to store my elements, and proceed with Array only
 
 `Approach - 2`
 Converting the whole list into a dictionary with keys as disticnt first character, and values as all the strings starting with that key, this should have given me initial dictionary with all the records
 So, when user enters the first character, there will be new filterList with all the searched results, the time complexity for searching should be constant i.e O(1).
 When user enters the second character, instead of using the original list, we can use the filtered list to implement our search, and so on.
 The complexity for this result will be O(K), where K is the count of filterLists.
 While this solution can be extensively modified to bring our search efficiency as O(1) by creating dictionary at each step, I see some caveat in this solution. This is all in best case scenario. There can be issue when we face hashing collision. In that case our search will be O(N), hence bringing to Linear Search.
 
 
 `Approach - 3`
 Converting the whole list into some sort of `Tree` and store on the basis of indexing, while this will work and will be most efficient for searching, while trying to create a Tree from the list of cities, was very expensive in terms of time.
 
 While this works efficiently, when I tried converting the list of cities from array to Tree, it was taking lots of time in that and creation was not efficient, blocking the user from usage of app for few minutes. When I tried in background, the search was not happening on full list, because the list was still getting mapped into Tree, so I had to ditch this approach for this code challenge
 

 `Approach - 4`
 Using `Trie`/`Ternary Search Tree` / `Radix tree` - We can convert our list into these data structures and perform Prefix search, to have efficient search algorithm, giving us `Average time complexity of O(M), where M is the length of search text`
 All the data structures has there Pros and Cons, I find that `Approach 4` is the most suitable here, as it significantly improves the searching and has major use cases for Prefix Search.
 I was facing issues in creating this Data structre as per our need of mapping a `City` in `Trie` or other Data structures.
 
 Trie normally works with Strings, so, I took all the city names from Cities, and creatd `Trie`, and used to display it on List of table view , but was facing issue with selection and getting object of City instead of String for further usage.
 Although `approach 4` would have been most suitable for having a prefix search, I was facing lots of issues in implementing this data structure with City as Data Structure.
 
  
 `Conclusion and the approach used`
 After trying few of these approach like `1, 3, 4` I decided to go with `Approach 1` with `Binary Search`, because the list was sorted already and didn't require any extra converstion of list into different data structure which saved my loading and displaying time to user, increasing user experience and not keeping them waiting for long time.
 Also, the Search was efficient than linear, which was required for this code challenge.
 
 To achieve this I modified the generic binary search to search for a string in an array of strings. Expanded the binary search on strings such that instead of finding an exact match it looks if a string in our collection starts with our target strings. If a string starts with our target string we say that the target string is a prefix of that string.
  
 `SOLUTION`
 
     Since, there can potentially be many items in the array that start with the same prefix. So implemented a function `binarySearchFirst` which returns the index of the first string in the array that starts with a given prefix.
 
    Similarly implemented a function `binarySearchLast` that returns the index of the last string in the array that starts with a given prefix.
 
    The result will be data between StartIndex - EndIndex
 */

class SearchManager {
    
    private var cities: [City]
    private var prefixStartIndex: Int
    private var prefixEndIndex: Int
    
    /// Initialise the search Manager with cities
    init(with cities: Cities) {
        self.cities = cities
        prefixStartIndex = 0
        prefixEndIndex = cities.count - 1
    }
    
    /// Returns all the cities in between StartIndex `prefixStartIndex` and endIndex `prefixEndIndex`
    func search(for text: String) -> Cities {
        self.prefixStartIndex = binarySearchFirst(array: self.cities, target: text.lowercased())
        self.prefixEndIndex = binarySearchLast(array: self.cities, target: text.lowercased())
        if prefixStartIndex == -1 || prefixEndIndex == -1 { return [] }
        return Array(self.cities[prefixStartIndex...prefixEndIndex])
    }
    
    // MARK: Search Algorithm
    
    /// Returns an index in one of 2 cases:
    /// 1. The left and right indices are equal and the target is a prefix of the current value
    /// 2. The target is a prefix of the current value and the previous element in our array is not a prefix of the current value.
    
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
    
}
