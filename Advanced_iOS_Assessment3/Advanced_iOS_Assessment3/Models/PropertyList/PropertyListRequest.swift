//
//  PropertyListRequest.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 25/9/2023.
//
//this file containts objects that is used to encode into a JSON file for a POST request to search for hotels.
import Foundation
struct PropertyListRequest: Encodable {
    let currency: String
    let eapid: Int
    let locale : String
    let siteId : Int
    let destination : Destination
    let checkInDate : CheckInDate
    let checkOutDate : CheckOutDate
    let rooms : [Rooms]
    let resultsStartingIndex : Int?
    let resultsSize: Int?
    let sort: String?
    let filters: Filters?
}

struct Children: Encodable {
    let age: Int
}

struct Destination: Encodable {
    let regionId: String
    let coordinates: Coordinates
}

struct PriceRequest: Codable {
    let maximunPrice: Int
    let minimunPrice: Int

    enum CodingKeys: String, CodingKey {
        case maximunPrice = "max"
        case minimunPrice = "min"
    }
}

struct Rooms: Identifiable, Encodable {
    let id: UUID = UUID()
    //this is a property to display the index number on the ui
    let index: Int
    let adults: Int
    
    let children: [Children]
    
    //this will not include the room id when encoding into a JSON format.
    //The room id is needed to loop through a list of rooms in the views.
    enum CodingKeys: String, CodingKey {
        case adults, children
    }
}

//this is used to filter the hotel results
struct Filters: Encodable {
    let price: PriceRequest
    

    enum CodingKeys: String, CodingKey {
        case price = "price"
    }
}
