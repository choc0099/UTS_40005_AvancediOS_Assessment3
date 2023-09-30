//
//  PropertyContentResponse.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 1/10/2023.
//

import Foundation

struct PropertyContentResponse: Hashable, Codable {
    let propertyData: PropertyContentData?
    
    enum CodingKeys: String, CodingKey {
        case propertyData = "data"
    }
}


struct PropertyContentData: Hashable, Codable {
    let propertyInfo: PropertyInfo?

    enum CodingKeys: String, CodingKey {
        case propertyInfo = "propertyInfo"
    }
}

struct PropertyInfo: Hashable, Codable {
    let typeName : String
    let propertyContentSectionGroups : PropertyContentSectionGroups?

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case propertyContentSectionGroups = "propertyContentSectionGroups"
    }

}

struct PropertyContentSectionGroups: Hashable, Codable {
    let typeName: String
    let aboutThisProperty : AboutThisProperty?
    let aboutThisHost : String?
    let amenities : PropertyContentAmenities?
    let importantInfo : String?
    let policies : Policy?
    let specialFeatures : SpecialFeatures?

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case aboutThisProperty = "aboutThisProperty"
        case aboutThisHost = "aboutThisHost"
        case amenities = "amenities"
        case importantInfo = "importantInfo"
        case policies = "policies"
        case specialFeatures = "specialFeatures"
    }
}
