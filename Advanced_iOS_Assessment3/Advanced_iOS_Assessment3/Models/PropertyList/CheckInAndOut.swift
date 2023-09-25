//
//  CheckInAndOut.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 25/9/2023.
//

import Foundation

struct SearchCriteria : Codable {
    let typename : String?
    let resolvedDateRange : ResolvedDateRange?

    enum CodingKeys: String, CodingKey {

        case typename = "__typename"
        case resolvedDateRange = "resolvedDateRange"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        resolvedDateRange = try values.decodeIfPresent(ResolvedDateRange.self, forKey: .resolvedDateRange)
    }
}

struct ResolvedDateRange : Codable {
    let typename : String?
    let checkInDate : CheckInDate?
    let checkOutDate : CheckOutDate?

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case checkInDate = "checkInDate"
        case checkOutDate = "checkOutDate"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        checkInDate = try values.decodeIfPresent(CheckInDate.self, forKey: .checkInDate)
        checkOutDate = try values.decodeIfPresent(CheckOutDate.self, forKey: .checkOutDate)
    }

}

struct CheckInDate : Codable {
    let typename : String?
    let day : Int?
    let month : Int?
    let year : Int?

    enum CodingKeys: String, CodingKey {

        case typename = "__typename"
        case day = "day"
        case month = "month"
        case year = "year"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        day = try values.decodeIfPresent(Int.self, forKey: .day)
        month = try values.decodeIfPresent(Int.self, forKey: .month)
        year = try values.decodeIfPresent(Int.self, forKey: .year)
    }
}


struct CheckOutDate : Codable {
    let typename : String?
    let day : Int?
    let month : Int?
    let year : Int?

    enum CodingKeys: String, CodingKey {

        case typename = "__typename"
        case day = "day"
        case month = "month"
        case year = "year"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        day = try values.decodeIfPresent(Int.self, forKey: .day)
        month = try values.decodeIfPresent(Int.self, forKey: .month)
        year = try values.decodeIfPresent(Int.self, forKey: .year)
    }
}
