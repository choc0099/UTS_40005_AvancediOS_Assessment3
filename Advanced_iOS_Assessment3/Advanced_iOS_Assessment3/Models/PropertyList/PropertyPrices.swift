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
    let options : [Option]?
    let priceMessaging : String?
    let lead : Lead
    let strikeOut : String?
    let displayMessages : [DisplayMessages]?
    let strikeOutType : String?
    let priceMessages : [PriceMessages]?

    enum CodingKeys: String, CodingKey {

        case typeName = "__typename"
        case options = "options"
        case priceMessaging = "priceMessaging"
        case lead = "lead"
        case strikeOut = "strikeOut"
        case displayMessages = "displayMessages"
        case strikeOutType = "strikeOutType"
        case priceMessages = "priceMessages"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typeName = try values.decode(String.self, forKey: .typeName)
        options = try values.decodeIfPresent([Option].self, forKey: .options)
        priceMessaging = try values.decodeIfPresent(String.self, forKey: .priceMessaging)
        lead = try values.decode(Lead.self, forKey: .lead)
        strikeOut = try values.decodeIfPresent(String.self, forKey: .strikeOut)
        displayMessages = try values.decodeIfPresent([DisplayMessages].self, forKey: .displayMessages)
        strikeOutType = try values.decodeIfPresent(String.self, forKey: .strikeOutType)
        priceMessages = try values.decodeIfPresent([PriceMessages].self, forKey: .priceMessages)
    }
}

struct DisplayMessages: Hashable, Codable {
    let typeName: String
    let lineItems : [LineItem]

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case lineItems = "lineItems"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typeName = try values.decode(String.self, forKey: .typeName)
        lineItems = try values.decode([LineItem].self, forKey: .lineItems)
    }

}


struct PriceMessages: Hashable, Codable {
    let typeName : String
    let value: String

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

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typeName = try values.decode(String.self, forKey: .typeName)
        strikeOut = try values.decodeIfPresent(String.self, forKey: .strikeOut)
        disclaimer = try values.decodeIfPresent(String.self, forKey: .disclaimer)
        formattedDisplayPrice = try values.decode(String.self, forKey: .formattedDisplayPrice)
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

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typeName = try values.decode(String.self, forKey: .typeName)
        amount = try values.decode(Double.self, forKey: .amount)
        currencyInfo = try values.decodeIfPresent(CurrencyInfo.self, forKey: .currencyInfo)
        formatted = try values.decode(String.self, forKey: .formatted)
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
    let price: Price
    let role: String?

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case disclaimer = "disclaimer"
        case price = "price"
        case role = "role"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typeName = try values.decode(String.self, forKey: .typeName)
        disclaimer = try values.decodeIfPresent(String.self, forKey: .disclaimer)
        price = try values.decode(Price.self, forKey: .price)
        role = try values.decodeIfPresent(String.self, forKey: .role)
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

