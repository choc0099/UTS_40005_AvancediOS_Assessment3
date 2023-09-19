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

//this is a base struct to find hotels by city and it will have some struct object properties
struct Location : Identifiable, Hashable, Codable {
    let id: Int
    var gaiaId: Int // this is an unique identifier from the backend side of the search result
    var regionName: RegionNames
    var coordinates: Coordinates
    var hotelAddress: HotelAddress?
}

struct HierarchyInfo: Hashable, Codable {
    var country: Country
}

struct Country: Hashable, Codable {
    var name: String
    var isoCode2: String
    var isoCode3: String
}

//this will be used for the map
struct Coordinates: Hashable, Codable {
    var latitude: Double
    var longitutde: Double
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
