//
//  PropertyContentModels.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 1/10/2023.
//

//all of these structs are related to property content infomraiton retrieve via JSON.
import Foundation

struct AboutThisProperty: Hashable, Codable {
    let sectionName: String?
    let sections: [PropertySection]?
}

struct PropertySection: Hashable, Codable {
    let sectionName: String?
    let header: Header?
    let bodySubSections: [BodySubSections]?
}

struct Header: Hashable, Codable {
    let text: String?
    let subText: String?
}


struct BodySubSections: Hashable, Codable {
    let elements : [PropertySectionElement]?
    //let expando : String?
    //let maxColumns : Int
}

struct PropertySectionElement: Hashable, Codable {
    let header : Header?
    let items : [PropertySectionItem]?
}

struct PropertySectionItem: Hashable, Codable {
    let content: PropertyContent?
}

struct PropertyContent: Hashable, Codable {
    let text : String?
    let markupType : String?
    let primary: PrimaryContent?
}

struct PrimaryContent: Hashable, Codable {
    let value: String?
}
