//
//  PropertyContentModels.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 1/10/2023.
//

import Foundation

struct AboutThisProperty: Hashable, Codable {
    let typeName : String
    let sectionName : String?
    let sections : [PropertySection]?

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case sectionName = "sectionName"
        case sections = "sections"
    }
}

struct PropertySection: Hashable, Codable {
    let typeName: String
    let sectionName: String?
    let header: Header?
    let bodySubSections: [BodySubSections]?
    let action : String?

    enum CodingKeys: String, CodingKey {

        case typeName = "__typename"
        case sectionName = "sectionName"
        case header = "header"
        case bodySubSections = "bodySubSections"
        case action = "action"
    }
}

struct Header: Hashable, Codable {
    let typeName : String
    let text : String
    let subText : String?
    let icon : String?
    let headerImage : String?

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case text = "text"
        case subText = "subText"
        case icon = "icon"
        case headerImage = "headerImage"
    }
}


struct BodySubSections: Hashable, Codable {
    let typeName : String
    let elements : [PropertySectionElement]?
    let expando : String?
    let maxColumns : Int
    
    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case elements = "elements"
        case expando = "expando"
        case maxColumns = "maxColumns"
    }
    
}

struct PropertySectionElement: Hashable, Codable {
    let typeName : String
    let header : Header
    let items : [PropertySectionItem]?

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case header = "header"
        case items = "items"
    }

}

struct PropertySectionItem: Hashable, Codable {
    let typeName : String
    let content: Content

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case content = "content"
    }
}

struct Content: Hashable, Codable {
    let typeName : String
    let text : String
    let markupType : String?

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case text = "text"
        case markupType = "markupType"
    }
}
