//
//  PropertyPrices.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 25/9/2023.
//
//this is a file that has all the price related stuff referencing the property.

import Foundation

//the price struct displays different types of prices.
struct Price: Hashable, Codable {
    let typeName : String
    let lead : Lead
    let strikeOut: StrikeOut?

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case lead = "lead"
        case strikeOut = "strikeOut"
    }
}

struct StrikeOut: Hashable, Codable {
    let typeName: String
    let amount: Double
    let formatted: String
    
    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case amount, formatted
    }
}

//this is a struct that is retrieved from the JSON to view hotel prices based on numbers of nights
struct Lead: Hashable, Codable {
    let typeName: String
    let amount: Double
    let currencyInfo: CurrencyInfo?
    let formatted: String

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case amount = "amount"
        case currencyInfo = "currencyInfo"
        case formatted = "formatted"
    }
}


struct CurrencyInfo: Hashable, Codable {
    let typeName: String
    let code: String
    let symbol: String

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case code = "code"
        case symbol = "symbol"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typeName = try values.decode(String.self, forKey: .typeName)
        code = try values.decode(String.self, forKey: .code)
        symbol = try values.decode(String.self, forKey: .symbol)
    }
}


struct LineItem: Hashable, Codable {
    let typeName: String
    let disclaimer : String?
    let price: Price?
    let role: String?

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case disclaimer = "disclaimer"
        case price = "price"
        case role = "role"
    }
}

struct PriceRange: Hashable, Codable {
    let typeName: String
    let max: Double
    let min: Double

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case max = "max"
        case min = "min"
    }
}

