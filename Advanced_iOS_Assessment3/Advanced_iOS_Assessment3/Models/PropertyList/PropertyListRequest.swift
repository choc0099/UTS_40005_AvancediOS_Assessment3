//
//  PropertyListRequest.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 25/9/2023.
//
//this file containts objects that is used to encode into a JSON file for a POST request to search for hotels.
import Foundation
struct PropertyListRequest: Codable, Hashable{
    let currency: String
    let eapid: Int
    let locale : String
    let siteId : Int
    let destination : Destination
    let checkInDate : CheckInDate
    let checkOutDate : CheckOutDate
    let rooms : [Room]
    let resultsStartingIndex : Int?
    let numbersOfResults: Int
    let sort: String?
    let filters: Filters?
    
    enum CodingKeys: String, CodingKey {
        case numbersOfResults = "resultsSize"
        case currency
        case eapid
        case locale
        case siteId
        case destination
        case checkInDate
        case checkOutDate
        case rooms
        case resultsStartingIndex
        case sort
        case filters
    }
    
    init(currency: String, eapid: Int, locale: String, siteId: Int, destination: Destination, checkInDate: CheckInDate, checkOutDate: CheckOutDate, rooms: [Room], sortAndFilterSettings userPref: PropertyListPreference) {
        self.currency = currency
        self.eapid = eapid
        self.locale = locale
        self.siteId = siteId
        self.destination = destination
        self.checkInDate = checkInDate
        self.checkOutDate = checkOutDate
        self.rooms = rooms
        self.resultsStartingIndex = 0
        self.numbersOfResults = userPref.numbersOfResults
        self.sort = userPref.sort
        self.filters = userPref.filter
    }
}

struct Children: Identifiable, Hashable, Codable {
    let id: UUID = UUID()
    var age: Int
    
     func encode(to encoder: Encoder) throws {
         var container = encoder.container(keyedBy: CodingKeys.self)
         try container.encode(age, forKey: .age)
     }
    
    enum CodingKeys: CodingKey {
        case age
    }
    
    init(age: Int) {
        self.age = age
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.age = try container.decode(Int.self, forKey: .age)
    }
}

struct Destination: Hashable, Codable {
    let regionId: String
    let coordinates: Coordinates?
}

struct PriceRequest: Hashable, Codable {
    let maximunPrice: Int
    let minimunPrice: Int

    enum CodingKeys: String, CodingKey {
        case maximunPrice = "max"
        case minimunPrice = "min"
    }
}

struct Room: Hashable, Identifiable, Codable {
    let id = UUID()
    var adults: Int
    var children: [Children]
    
    enum CodingKeys: String, CodingKey {
        case adults, children
    }
}

//this is used to filter the hotel results
struct Filters: Codable, Hashable {
    let price: PriceRequest?
    let accessibility: [String]?
    let travellerType: [String]?
    let amenities: [String]?
    let star: [String]?
}



//this is a struct that will be used to store property prefences including price filtering and sorting
struct PropertyListPreference: Codable {
    let numbersOfResults: Int
    let sort: String?
    let filter: Filters?
}
