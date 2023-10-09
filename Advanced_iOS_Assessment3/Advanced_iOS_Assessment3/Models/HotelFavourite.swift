//
//  HotelFavourite.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 5/10/2023.
//

import Foundation

struct HotelFavourite: Identifiable, Codable {
    let id: UUID = UUID() //used internally to loop through the lists in swiftUi
    var hotelId: String
    var hotelName: String
    var hotelAddress: String
    var imageUrl: String
    var imageDescription: String?
    
    //converts it to a dictionary object so it can be used to store it in Firebase
    var dictionary:  [String:Any] {
        return ["hotelName": hotelName,
                           "imageUrl": imageUrl,
                           "hotelAddress": hotelAddress,
                           "imageDescription": imageDescription ?? NSNull()]
    }
}
