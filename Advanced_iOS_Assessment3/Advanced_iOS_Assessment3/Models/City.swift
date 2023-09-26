//
//  City.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 19/9/2023.
//

import Foundation
import MapKit

enum LocationTyoe: String, Decodable {
    case neighbourHood = "NEIGHBOURHOOD"
    case hotel = "HOTEL"
    case city = "CITY"
}

//this is uesed on the whole body of the JSON Response
struct SearchResponse<T : SearchResult>: Hashable, Decodable {
    var query: String
    var runtimeId: String
    let errorStatus: String //the error status is displayed on the top of the JSON file.
    var searchResults: [T]?
    
    //this is used to decode the JSON file
    enum CodingKeys: String, CodingKey {
        case query = "q"
        case runtimeId = "rid"
        case errorStatus = "rc"
        case searchResults = "sr"
    }
}

//this is a base struct to find hotels by city and it will have some struct object properties
struct HotelSearchResult: SearchResult, Hashable, Decodable {
    static func == (lhs: HotelSearchResult, rhs: HotelSearchResult) -> Bool {
        lhs.id == rhs.id // Return true if the IDs are equal
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: Int
    var type: String
    var regionNames: RegionNames
    var coordinates: Coordinates
    var hotelAddress: HotelAddress?
    var hotelId: Int?
    var cityId: Int?
    
    //this is used to for JSON Parsing such as decoding it from JSON.
    enum CodingKeys: String, CodingKey {
        case id = "index"
        //if all the rest is the same in the json response, all still eeds to be entered without declaring a different code.
        case regionNames,coordinates, type, hotelAddress, cityId, hotelId
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try Int(container.decode(String.self, forKey: .id))!
        self.regionNames = try container.decode(RegionNames.self, forKey: .regionNames)
        self.coordinates = try container.decode(Coordinates.self, forKey: .coordinates)
        self.type = try container.decode(String.self, forKey: .type)
        self.hotelAddress = try container.decodeIfPresent(HotelAddress.self, forKey: .hotelAddress)
        if let haveCityId = try container.decodeIfPresent(String.self, forKey: .cityId) {
            self.cityId = Int(haveCityId)
        }
        if let haveHotelId = try container.decodeIfPresent(String.self, forKey: .hotelId) {
            self.hotelId = Int(haveHotelId)
        }
    }
}

struct NeighborhoodSearchResult: SearchResult {
    let id: Int
    let type: String
    let regionNames: RegionNames
    let gaiaId: Int?
    var coordinates: Coordinates
    let hierarchyInfo: HierarchyInfo?
    
    enum CodingKeys: String, CodingKey {
        case id = "index"
        case type, regionNames, gaiaId, coordinates, hierarchyInfo
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try Int(container.decode(String.self, forKey: .id))!
        self.type = try container.decode(String.self, forKey: .type)
        self.regionNames = try container.decode(RegionNames.self, forKey: .regionNames)
        if let haveGId = try container.decodeIfPresent(String.self, forKey: .gaiaId) {
            self.gaiaId = Int(haveGId)
        }
        else {
            self.gaiaId = nil
        }
        self.coordinates = try container.decode(Coordinates.self, forKey: .coordinates)
        self.hierarchyInfo = try container.decodeIfPresent(HierarchyInfo.self, forKey: .hierarchyInfo)
    }
    
    
}

struct HierarchyInfo: Hashable, Decodable {
    var country: Country?
}

struct Country: Hashable, Decodable {
    var name: String?
    var isoCode1: String?
    var isoCode2: String?
    var isoCode3: String?
}

//this will be used for the map
struct Coordinates: Hashable, Codable {
    var latitude: Double
    var longitude: Double
    
    //nauelly converts from a string to double
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.latitude = try Double(container.decode(String.self, forKey: .latitude))!
        self.longitude = try Double(container.decode(String.self, forKey: .longitude))!
    }
    
    //used for JSON file decoding.
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "long"
    }
}

//this will have multiple forms of region names.
struct RegionNames: Hashable, Decodable {
    var fullName: String
    var shortName: String
    var displayName: String
    var primaryDisplayName: String
    var secondaryDisplayName: String
    var lastSearchName: String
}

struct HotelAddress: Hashable, Decodable {
    var street: String
    var city: String
    var province: String
}

//this is used to define similar types for differnt objects that have similar properties

protocol SearchResult: Identifiable, Hashable, Decodable {
    var id: Int {get}
    var type: String {get}
    var regionNames: RegionNames {get}
    var coordinates: Coordinates {get set}
}
