//
//  HotelFavourite.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 5/10/2023.
//

import Foundation

struct HotelFavourite: Identifiable, Hashable {
    let id: UUID = UUID() //used internally to loop through the lists in swiftUi
    let hotelId: String
    let hotelName: String
    let hotelAddress: String
    let imageUrl: String
    let imageDescription: String?
    
    //converts it to a dictionary object so it can be used to store it in Firebase
    var dictionary: [String: [String:Any]] {
        return [hotelId : ["hotelName": hotelName,
                           "imageUrl": imageUrl,
                           "hotelAddress": hotelAddress,
                           "imageDescription": imageDescription ?? NSNull()]]
    }
}
