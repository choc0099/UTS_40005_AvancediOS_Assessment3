//
//  PropertyItem.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 25/9/2023.
//

import Foundation

struct Availability:Hashable, Codable {
    let typeName: String
    let isAvailable: Bool
    let minRoomsLeft: Int?

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case isAvailable = "available"
        case minRoomsLeft = "minRoomsLeft"
    }
}

struct Reviews: Hashable, Codable {
    let typeName : String
    let score : Double
    let total : Int

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case score = "score"
        case total = "total"
    }
}


struct ResultsTitleModel : Codable {
    let typename : String?
    let header : String?

    enum CodingKeys: String, CodingKey {

        case typename = "__typename"
        case header = "header"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        header = try values.decodeIfPresent(String.self, forKey: .header)
    }

}


