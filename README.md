# City-Search

### Requirements
* iOS 11.4+

### XCODE USED
  * Xcode 12.4 and xcode 12.5

### Architecture used
  MVVM and callbacks are used for databinding. The decision behind using MVVM was to to improve unit testability and keeping the code segregated and properly defined with their funtionalities.
  For databinding, I wanted to use ReactiveSwift, but since no third party code was required, I chose callbacks instead.


### FILE LOAD
  The folder `Foundation` deals with logic to load a file from a bundle, parse it in required Model.
  The idea was to have it as reusable, which further can be extended to cater API calls.
  The component expects a `file name` and `bundle` . Bundle can be `Main` or any other bundle if used.

### Search Algorithm
  
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
    
    So searching will give us O(logN), and getting the data from indexes will O(1)
 */

### Running

Simply double tap on `CitySearch.xcodeproj`,  `cmd+r` and we are running.

### Unit Test
Simply `cmd+u` to run the unit tests
  Have added only Unit testing for code challenge, no UI test added.
  #### Unit test coverage - 63%

### Code Folder Structure
* CitySearch
    * DataSource
    * Foundation
    * Model
    * Service
    * Supporting
    * UI
    * Utilities
    * ViewModel
 * CitySearchTests
 * Products


### FUTURE IMPROVEMENTS
  * Improve Search by using more efficient algorithms
  * Improve unit testing and increase the coverage
  

