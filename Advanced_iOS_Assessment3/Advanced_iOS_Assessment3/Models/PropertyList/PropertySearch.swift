//
//  PropertySearch.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 25/9/2023.
//

import Foundation
//this is a file that will have all the property related object from the property response JSON

//this is the main point of the JSON response.
struct PropertyResponse: Codable {
    let data: PropertyData
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(PropertyData.self, forKey: .data)
    }
}


struct PropertyData : Codable {
    let propertySearch : PropertySearch

    enum CodingKeys: String, CodingKey {
        case propertySearch = "propertySearch"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        propertySearch = try values.decode(PropertySearch.self, forKey: .propertySearch)
    }

}
// this is a sub structure of the property response.
// for this assignemt, I have chosed to use the properties list and left all the other ones out
struct PropertySearch: Codable {
    let typeName: String
    let properties: [Property]

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case properties = "properties"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typeName = try values.decode(String.self, forKey: .typeName)
        properties = try values.decode([Property].self, forKey: .properties)
    }
}

//this is the main object that displays property information.
struct Property: Identifiable, Hashable, Codable {
    let id: UUID = UUID()
    let hotelId: String
    let typeName: String
    let name: String
    let availability: Availability
    let propertyImage: PropertyImage?
    let mapMarker: PropertyMapMarker
    let price: Price
    let reviews: Reviews?
    let regionId : String
    
    //this is used for testing and previews
    init(name: String, formattedPrice: String, formattedDiscount: String, isAvaliable: Bool, roomsAvaliable: Int?, propertyImage: PropertyImage?, review: Double) {
        self.hotelId = "0"
        self.typeName = ""
        self.name = name
        self.price = Price(typeName: "", lead: Lead(typeName: "", amount: 0, currencyInfo: nil, formatted: formattedPrice), strikeOut: StrikeOut(typeName: "", amount: 0, formatted: formattedDiscount))
        self.availability = Availability(typeName: "", isAvailable: isAvaliable, minRoomsLeft: roomsAvaliable)
        self.regionId = ""
        self.mapMarker = PropertyMapMarker(label: "", coordinates: PropertyCoordinates(typeName: "", latitude: 0, longitude: 0))
        self.propertyImage = propertyImage
        self.reviews = Reviews(typeName: "", score: review, total: 10)
    }
    
    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case hotelId = "id"
        //case featuredMessages = "featuredMessages"
        case name = "name"
        case availability = "availability"
        case propertyImage = "propertyImage"
        case mapMarker = "mapMarker"
        case price = "price"
        case reviews = "reviews"
        case regionId = "regionId"
    }
}

//these are used to retrieve the hotel images.
struct PropertyImage: Hashable, Codable {
    let typename: String
    let alt: String?
    let accessibilityText : String?
    let image: HotelImage?
    let subjectId: Int?
    let imageId: String?
    
    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case alt = "alt"
        case image = "image"
        case subjectId = "subjectId"
        case accessibilityText, imageId
    }
}
//a struct from the JSON that returns components for hotel images.
struct HotelImage: Hashable, Codable {
    let typeName : String
    let description : String?
    let url : String

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case description = "description"
        case url = "url"
    }

}
