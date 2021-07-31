//
//  Cities.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 29/7/21.
//

import Foundation

// MARK: - Cities

/// Typealias to represent all the `cities`
  typealias Cities = [City]

// MARK: - City
/**
 Model to represent `City`
 Marking all the properties nullable, because didn't wanted it to be tightly coupled. It might be parsing fail or crash, if any of the value comes as nil from backend. To avoid that, and to remove that dependency, thought to take everything as optional
 */
struct City: Decodable {
    let country: String?
    let city: String?
    let id: Int?
    let coordinates: Coordinates?
    
    enum CodingKeys: String, CodingKey {
        case country
        case city = "name"
        case id = "_id"
        case coordinates = "coord"
    }
    
    init(country: String? = "", city: String? = "", id: Int? = -1, coordinates: Coordinates? = nil) {
        self.city = city
        self.country = country
        self.id = id
        self.coordinates = coordinates
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.country = try values.decodeIfPresent(String.self, forKey: .country)
        self.city = try values.decodeIfPresent(String.self, forKey: .city)
        self.id = try values.decodeIfPresent(Int.self, forKey: .id)
        self.coordinates = try values.decodeIfPresent(Coordinates.self, forKey: .coordinates)
    }
}

// MARK: - Coord
struct Coordinates: Decodable {
    let lon, lat: Double
}

extension City {
    
    /**
     This will be combination of `City` and `Country` -> `City, Country`.
     If `City` and `Country` is available, then it will return `City, Country`
     for e.g
     `City = Hurzuf` and `Country = UA`
     then `fullAddress` will be `Hurzuf, UA`
     
     if `City = nil / ""` and `Country = UA` , then `fullAddress` will be ` UA`
     if `City = Hurzuf` and `Country = nil / ""` , then `fullAddress` will be ` Hurzuf`
     */
    
    var fullAddress: String {
        var arr: [String] = []
        
        if let city = self.city,
           !city.isEmpty {
            arr.append(city)
        }
        if let country = self.country,
           !country.isEmpty {
            arr.append(country)
        }
        return arr.joined(separator: ", ")
    }
}
