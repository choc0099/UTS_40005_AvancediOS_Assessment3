//
//  PropertyPrices.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 25/9/2023.
//
//this is a file that has all the price related stuff referencing the property.

import Foundation

struct Price : Codable {
    let typename : String?
    let options : [Options]?
    let priceMessaging : String?
    let lead : Lead
    let strikeOut : String?
    let displayMessages : [DisplayMessages]?
    let strikeOutType : String?
    let priceMessages : [PriceMessages]?

    enum CodingKeys: String, CodingKey {

        case typename = "__typename"
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
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        options = try values.decodeIfPresent([Options].self, forKey: .options)
        priceMessaging = try values.decodeIfPresent(String.self, forKey: .priceMessaging)
        lead = try values.decode(Lead.self, forKey: .lead)
        strikeOut = try values.decodeIfPresent(String.self, forKey: .strikeOut)
        displayMessages = try values.decodeIfPresent([DisplayMessages].self, forKey: .displayMessages)
        strikeOutType = try values.decodeIfPresent(String.self, forKey: .strikeOutType)
        priceMessages = try values.decodeIfPresent([PriceMessages].self, forKey: .priceMessages)
    }
}

struct DisplayMessages : Codable {
    let typename : String?
    let lineItems : [LineItems]?

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case lineItems = "lineItems"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        lineItems = try values.decodeIfPresent([LineItems].self, forKey: .lineItems)
    }

}


struct PriceMessages : Codable {
    let typename : String?
    let value : String?

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case value = "value"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        value = try values.decodeIfPresent(String.self, forKey: .value)
    }
}

struct Options : Codable {
    let typename : String?
    let strikeOut : String?
    let disclaimer : String?
    let formattedDisplayPrice : String?

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case strikeOut = "strikeOut"
        case disclaimer = "disclaimer"
        case formattedDisplayPrice = "formattedDisplayPrice"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        strikeOut = try values.decodeIfPresent(String.self, forKey: .strikeOut)
        disclaimer = try values.decodeIfPresent(String.self, forKey: .disclaimer)
        formattedDisplayPrice = try values.decodeIfPresent(String.self, forKey: .formattedDisplayPrice)
    }
}


struct Lead: Codable {
    let typename : String?
    let amount : Double?
    let currencyInfo : CurrencyInfo?
    let formatted : String

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case amount = "amount"
        case currencyInfo = "currencyInfo"
        case formatted = "formatted"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        amount = try values.decodeIfPresent(Double.self, forKey: .amount)
        currencyInfo = try values.decodeIfPresent(CurrencyInfo.self, forKey: .currencyInfo)
        formatted = try values.decode(String.self, forKey: .formatted)
    }
}


struct CurrencyInfo: Codable {
    let typename : String?
    let code : String?
    let symbol : String?

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case code = "code"
        case symbol = "symbol"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
    }
}


struct LineItems : Codable {
    let typename : String?
    let disclaimer : String?
    let price : Price?
    let role : String?

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case disclaimer = "disclaimer"
        case price = "price"
        case role = "role"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        disclaimer = try values.decodeIfPresent(String.self, forKey: .disclaimer)
        price = try values.decodeIfPresent(Price.self, forKey: .price)
        role = try values.decodeIfPresent(String.self, forKey: .role)
    }

}

struct PriceRange : Codable {
    let typename : String?
    let max : Double?
    let min : Double?

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case max = "max"
        case min = "min"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        max = try values.decodeIfPresent(Double.self, forKey: .max)
        min = try values.decodeIfPresent(Double.self, forKey: .min)
    }

}


struct PriceMetadata : Codable {
    let typename : String?
    let discountType : String?
    let rateDiscount : String?
    let totalDiscountPercentage : String?

    enum CodingKeys: String, CodingKey {

        case typename = "__typename"
        case discountType = "discountType"
        case rateDiscount = "rateDiscount"
        case totalDiscountPercentage = "totalDiscountPercentage"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        discountType = try values.decodeIfPresent(String.self, forKey: .discountType)
        rateDiscount = try values.decodeIfPresent(String.self, forKey: .rateDiscount)
        totalDiscountPercentage = try values.decodeIfPresent(String.self, forKey: .totalDiscountPercentage)
    }

}


struct PriceAfterLoyaltyPointsApplied : Codable {
    let typename : String?
    let options : [Options]?
    let lead : Lead?

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case options = "options"
        case lead = "lead"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        options = try values.decodeIfPresent([Options].self, forKey: .options)
        lead = try values.decodeIfPresent(Lead.self, forKey: .lead)
    }
}

struct PricingScheme: Codable {
    let typename: String?
    let type: String?

    enum CodingKeys: String, CodingKey {

        case typename = "__typename"
        case type = "type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }

}

