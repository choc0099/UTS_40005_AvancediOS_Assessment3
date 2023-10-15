//
//  PropertyPolicyAndFeatures.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 1/10/2023.
//

import Foundation

struct PropertyPolicies: Hashable, Codable {
    let typeName: String
    let checkInInstructions: [String]?
    let childAndBed: ChildAndBed?
    let needToKnow: NeedToKnow?
    let mentions: Mention?
    let pets: Pets?

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case mentions = "shouldMention"
        case checkInInstructions, childAndBed, needToKnow, pets
    }
}

struct ChildAndBed: Hashable, Codable {
    let typeName: String
    let childInformation: [String]
    
    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case childInformation = "body"
    }
}

struct NeedToKnow: Hashable, Codable {
    let typeName : String
    let body : [String]?
    let descriptions : [String]?
    let title : String?

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case body = "body"
        case descriptions = "descriptions"
        case title = "title"
    }
}

struct Pets: Hashable, Codable {
    let body : [String]?
    let descriptions : [String]?
    let title : String?
}
//this is property related details.
struct Mention: Hashable, Codable {
    let body: [String]?
    let descriptions: [String]?
    let title: String?
}

//this is used to get the location details including region coordinates.
struct PropertyLocation: Hashable, Codable {
    let address : PropertyAddress
    let coordinates : PropertyCoordinates
    let staticImage: PropertyStaticImage
}

//displays a snapshot of a Google Map image.
struct PropertyStaticImage: Hashable, Codable {
    let description : String?
    let url: String
}
//gets the property address information
struct PropertyAddress: Hashable, Codable {
    let addressLine: String
    let city: String
    let province : String
    let countryCode: String
    let firstAddressLine: String?
    let secondAddressLine: String?
}

