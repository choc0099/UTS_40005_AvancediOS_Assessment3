//
//  PropertyContentModels.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 1/10/2023.
//

import Foundation

struct AboutThisProperty: Hashable, Codable {
    let sectionName : String
    let sections : [PropertySection]?
}

struct PropertySection: Hashable, Codable {
    let sectionName: String?
    //let header: Header?
    let bodySubSections: [BodySubSections]?
    //let action : String?
}

struct Header: Hashable, Codable {
    let text : String?
    let subText : String?
}


struct BodySubSections: Hashable, Codable {
    let elements : [PropertySectionElement]?
    //let expando : String?
    //let maxColumns : Int
}

struct PropertySectionElement: Hashable, Codable {
    let header : Header
    let items : [PropertySectionItem]?
}

struct PropertySectionItem: Hashable, Codable {
    let typeName: String
    let content: PropertyContent

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case content = "content"
    }
}

struct PropertyContent: Hashable, Codable {
    let text : String
    let markupType : String?
}
