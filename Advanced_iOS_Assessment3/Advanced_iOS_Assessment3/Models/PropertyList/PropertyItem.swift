//
//  PropertyItem.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 25/9/2023.
//

import Foundation

struct Availability : Codable {
    let typename : String?
    let available : Bool?
    let minRoomsLeft : String?

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case available = "available"
        case minRoomsLeft = "minRoomsLeft"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        available = try values.decodeIfPresent(Bool.self, forKey: .available)
        minRoomsLeft = try values.decodeIfPresent(String.self, forKey: .minRoomsLeft)
    }

}

struct Reviews : Codable {
    let typename : String?
    let score : Double?
    let total : Int?

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case score = "score"
        case total = "total"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        score = try values.decodeIfPresent(Double.self, forKey: .score)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
    }

}

struct Summary : Codable {
    let typename : String?
    let matchedPropertiesSize : Int?
    let pricingScheme : PricingScheme?
    let regionCompression : String?
    let loyaltyInfo : LoyaltyInfo?
    let resultsTitleModel : ResultsTitleModel?
    let resultsSummary : [ResultsSummary]?

    enum CodingKeys: String, CodingKey {

        case typename = "__typename"
        case matchedPropertiesSize = "matchedPropertiesSize"
        case pricingScheme = "pricingScheme"
        case regionCompression = "regionCompression"
        case loyaltyInfo = "loyaltyInfo"
        case resultsTitleModel = "resultsTitleModel"
        case resultsSummary = "resultsSummary"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        matchedPropertiesSize = try values.decodeIfPresent(Int.self, forKey: .matchedPropertiesSize)
        pricingScheme = try values.decodeIfPresent(PricingScheme.self, forKey: .pricingScheme)
        regionCompression = try values.decodeIfPresent(String.self, forKey: .regionCompression)
        loyaltyInfo = try values.decodeIfPresent(LoyaltyInfo.self, forKey: .loyaltyInfo)
        resultsTitleModel = try values.decodeIfPresent(ResultsTitleModel.self, forKey: .resultsTitleModel)
        resultsSummary = try values.decodeIfPresent([ResultsSummary].self, forKey: .resultsSummary)
    }

}

struct LoyaltyInfo : Codable {
    let typename : String?
    let saveWithPointsMessage : String?
    let saveWithPointsActionMessage : String?

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case saveWithPointsMessage = "saveWithPointsMessage"
        case saveWithPointsActionMessage = "saveWithPointsActionMessage"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        saveWithPointsMessage = try values.decodeIfPresent(String.self, forKey: .saveWithPointsMessage)
        saveWithPointsActionMessage = try values.decodeIfPresent(String.self, forKey: .saveWithPointsActionMessage)
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


struct ResultsSummary : Codable {
    let typename : String?
    
    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
    }
}
