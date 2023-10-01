//
//  PropertyListRequest.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 25/9/2023.
//
//this file containts objects that is used to encode into a JSON file for a POST request to search for hotels.
import Foundation
struct PropertyListRequest: Encodable, Hashable{
    let currency: String
    let eapid: Int
    let locale : String
    let siteId : Int
    let destination : Destination
    let checkInDate : CheckInDate
    let checkOutDate : CheckOutDate
    let rooms : [Room]
    let resultsStartingIndex : Int?
    let numbersOfResults: Int?
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

struct Children: Identifiable, Hashable, Encodable {
    let id: UUID = UUID()
    let index: Int
    var age: Int
    
    enum CodingKeys: String, CodingKey {
        case age
    }
    
    func getAge() -> Int {
        return self.age
    }
}

struct Destination: Hashable, Encodable {
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

struct Room: Identifiable, Hashable, Encodable {
    let id: UUID = UUID()
    //this is a property to display the index number on the ui
    let index: Int
    var adults: Int
    
    var children: [Children]
    
    //this will not include the room id when encoding into a JSON format.
    //The room id is needed to loop through a list of rooms in the views.
    enum CodingKeys: String, CodingKey {
        case adults, children
    }
}

//this is used to filter the hotel results
struct Filters: Encodable, Hashable {
    let price: PriceRequest?
    let accessibility: [String]?
    let travellerType: [String]?
    let amenities: [String]?
    let star: [String]?
    
    enum CodingKeys: String, CodingKey {
        case price = "price"
    }
}



//this is a struct that will be used to store property prefences including price filtering and sorting
struct PropertyListPreference {
    let numbersOfResults: Int?
    let sort: String?
    let filter: Filters?
}
