//
//  City.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 19/9/2023.
//

import Foundation
import MapKit

enum LocationTyoe: String, Codable {
    case neighbourHood = "NEIGHBOURHOOD"
    case hotel = "HOTEL"
    case city = "CITY"
}



//this is uesed on the whole body of the JSON Response
struct SearchResponse<T : SearchResult>: Hashable, Codable {
    var query: String
    var runtimeId: String
    let errorStatus: String //the error status is displayed on the top of the JSON file.
    var searchResults: [T]
    
    //this is used to decode the JSON file
    enum CodingKeys: String, CodingKey {
        case query = "q"
        case runtimeId = "rid"
        case errorStatus = "rc"
        case searchResults = "sr"
    }
}

//this is a base struct to find hotels by city and it will have some struct object properties
struct HotelSearchResult: SearchResult, Identifiable, Hashable, Codable {
    static func == (lhs: HotelSearchResult, rhs: HotelSearchResult) -> Bool {
        lhs.id == rhs.id // Return true if the IDs are equal
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: String
    var type: String
    var regionNames: RegionNames
    var coordinates: Coordinates
    var hotelAddress: HotelAddress?
    var hotelId: String?
    var cityId: String?
    
    //this is used to for JSON Parsing such as decoding it from JSON.
    enum CodingKeys: String, CodingKey {
        case id = "index"
        //if all the rest is the same in the json response, all still eeds to be entered without declaring a different code.
        case regionNames,coordinates, type, hotelAddress, cityId, hotelId
    }
}

struct RegionSearchResult {
    
}

struct HierarchyInfo: Hashable, Codable {
    var country: Country?
}

struct Country: Hashable, Codable {
    var name: String?
    var isoCode1: String?
    var isoCode2: String?
    var isoCode3: String?
}

//this will be used for the map
struct Coordinates: Hashable, Codable {
    var latitude: String
    var longitude: String
    
    //used for JSON file decoding.
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "long"
    }
}

//this will have multiple forms of region names.
struct RegionNames: Hashable, Codable {
    var fullName: String
    var shortName: String
    var displayName: String
    var primaryDisplayName: String
    var secondaryDisplayName: String
    var lastSearchName: String
}

struct HotelAddress: Hashable, Codable {
    var street: String
    var city: String
    var province: String
}

//this is used to define similar types for differnt objects that have similar properties

protocol SearchResult: Identifiable, Hashable, Codable {
    var id: String {get}
    var type: String {get}
    var regionNames: RegionNames {get}
    var coordinates: Coordinates {get set}
}
