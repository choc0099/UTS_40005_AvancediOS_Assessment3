//
//  PropertyPolicyAndFeatures.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 1/10/2023.
//

import Foundation

struct Policy: Hashable, Codable {
    let typeName: String
    let sectionName: String?
    let sections: [PropertySection]?

    enum CodingKeys: String, CodingKey {

        case typeName = "__typename"
        case sectionName = "sectionName"
        case sections = "sections"
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

