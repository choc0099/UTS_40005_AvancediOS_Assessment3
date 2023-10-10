//
//  PropertyHistory.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 10/10/2023.
//

import Foundation

//this is a struct that will be usded to store propertySearches History
struct PropertyHistory: SavedHotel, Identifiable, Codable {
    let id: UUID = UUID()
    var hotelId: String
    var hotelName: String
    var hotelAddress: String
    var imageUrl: String
    var imageDescription: String?
    var numbersOfNights: Int
    var numbersOfRooms: Int
    var totalAdults: Int
    var totalChildren: Int
    var price: Double
    var dictionary: [String : Any] {
        return [
            "hotelId" : hotelId,
            "hotelName": hotelName,
            "hotelAddress" : hotelAddress,
            "imageUrl": imageUrl,
            "imageDescription": imageDescription ?? NSNull(),
            "numbersOfNights" : numbersOfNights,
            "totalAdults" : totalAdults,
            "totalChildren" : totalChildren,
            "price" : price
        ]
    }
    
    init(hotelId: String, hotelName: String, hotelAddress: String, imageUrl: String, imageDescription: String? = nil, numbersOfNights: Int, numbersOfRooms: Int, totalAdults: Int, totalChildren: Int, price: Double) {
        self.hotelId = hotelId
        self.hotelName = hotelName
        self.hotelAddress = hotelAddress
        self.imageUrl = imageUrl
        self.imageDescription = imageDescription
        self.numbersOfNights = numbersOfNights
        self.numbersOfRooms = numbersOfRooms
        self.totalAdults = totalAdults
        self.totalChildren = totalChildren
        self.price = price
    }
    
}

protocol SavedHotel: Identifiable {
    var id: UUID {get}
    var hotelId: String {get set}
    var hotelName: String {get set}
    var hotelAddress: String {get set}
    var imageUrl: String {get set}
    var imageDescription: String? {get set}
    var dictionary: [String: Any] {get}
}
