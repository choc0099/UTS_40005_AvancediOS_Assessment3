//
//  PropertyListRequest.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 25/9/2023.
//

import Foundation
struct PropertyListRequest: Encodable {
    let currency : String
    let eapid : Int
    let locale : String
    let siteId : Int
    let destination : Destination
    let checkInDate : CheckInDate
    let checkOutDate : CheckOutDate
    let rooms : [Rooms]
    let resultsStartingIndex : Int?
    let resultsSize : Int?
    let sort : String?
    let filters : Filters?
}

struct Children: Encodable {
    let age: Int
}

struct Destination: Encodable {
    let regionId: String?

    enum CodingKeys: String, CodingKey {
        case regionId = "regionId"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        regionId = try values.decodeIfPresent(String.self, forKey: .regionId)
    }
}

struct PriceRequest: Codable {
    let maximunPrice : Int
    let minimunPrice : Int

    enum CodingKeys: String, CodingKey {
        case maximunPrice = "max"
        case minimunPrice = "min"
    }
}

struct Rooms: Encodable {
    let adults : Int
    let children : [Children]
}

struct Filters: Encodable {
    let price : PriceRequest

    enum CodingKeys: String, CodingKey {
        case price = "price"
    }
}
