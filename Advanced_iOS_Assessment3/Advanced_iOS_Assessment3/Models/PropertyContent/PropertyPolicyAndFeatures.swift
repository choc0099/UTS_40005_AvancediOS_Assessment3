//
//  PropertyPolicyAndFeatures.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 1/10/2023.
//

import Foundation

struct Policy: Hashable, Codable {
    let typeName: String
    let checkInEnd: String?
    let checkInInstructions: [String]?
    let childAndBed: ChildAndBed?
    let needToKnow: NeedToKnow?

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case checkInEnd, checkInInstructions, childAndBed, needToKnow
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

struct SpecialFeatures: Hashable, Codable  {
    let typeName: String
    let sectionName : String?
    let sections : [PropertySection]?

    enum CodingKeys: String, CodingKey {
        case typeName = "typename"
        case sectionName = "sectionName"
        case sections = "sections"
    }
}

struct PropertyContentAmenities:Hashable, Codable {
    let typeName : String
    let sectionName : String?
    let sections : [PropertySection]?

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case sectionName = "sectionName"
        case sections = "sections"
    }
}

