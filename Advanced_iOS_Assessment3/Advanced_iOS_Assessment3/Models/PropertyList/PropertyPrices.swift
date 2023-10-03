//
//  PropertyPrices.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 25/9/2023.
//
//this is a file that has all the price related stuff referencing the property.

import Foundation

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

struct DisplayMessages: Hashable, Codable {
    let typeName: String
    let lineItems : [LineItem]?

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case lineItems = "lineItems"
    }
}


struct PriceMessages: Hashable, Codable {
    let typeName : String
    let value: String?

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case value = "value"
    }
}

struct Option: Hashable, Codable {
    let typeName : String
    let strikeOut : String?
    let disclaimer : String?
    let formattedDisplayPrice : String

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case strikeOut = "strikeOut"
        case disclaimer = "disclaimer"
        case formattedDisplayPrice = "formattedDisplayPrice"
    }
}


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

struct PriceRange:Hashable, Codable {
    let typeName: String
    let max : Double
    let min : Double

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case max = "max"
        case min = "min"
    }
}


struct PriceMetadata: Hashable, Codable {
    let typeName: String
    let discountType : String?
    let rateDiscount : String?
    let totalDiscountPercentage : String?

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case discountType = "discountType"
        case rateDiscount = "rateDiscount"
        case totalDiscountPercentage = "totalDiscountPercentage"
    }
}

struct PriceAfterLoyaltyPointsApplied : Codable {
    let typename : String?
    let options : [Option]?
    let lead : Lead?

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case options = "options"
        case lead = "lead"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        options = try values.decodeIfPresent([Option].self, forKey: .options)
        lead = try values.decodeIfPresent(Lead.self, forKey: .lead)
    }
}

struct PricingScheme:Hashable, Codable {
    let typeName: String
    let type: String

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case type = "type"
    }
}

