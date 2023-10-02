//
//  PropertyContentResponse.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 1/10/2023.
//

import Foundation

struct PropertyDetalResponse: Hashable, Codable {
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
    let typeName: String
    let summary: PropertySummary
    let propertyGallery: PropertyGallery?
    let contentSection: PropertyContentSectionGroups?
    
    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case contentSection = "propertyContentSectionGroups"
        case summary, propertyGallery
    }
}

struct PropertySummary: Hashable, Codable {
    let id: String
    let name: String
    let policies: PropertyPolicies?
    
}

struct PropertyContentSectionGroups: Hashable, Codable {
    let aboutThisProperty : AboutThisProperty?
    let importantInfo : String?
    //let policies: Policies?
    //let specialFeatures : SpecialFeatures?
}

struct PropertyGallery: Hashable, Codable {
    let imagesGrouped : String?
    let images : [PropertyImage]?
    let accessibilityLabel : String?
}

//this is a seperate policy struct for the content headers.
struct Policies: Hashable, Codable {
    let sectionName : String?
    let sections : [PropertySection]?
}




