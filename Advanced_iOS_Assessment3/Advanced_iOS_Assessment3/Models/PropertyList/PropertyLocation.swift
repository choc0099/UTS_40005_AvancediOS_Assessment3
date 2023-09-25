//
//  PropertyLocation.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 25/9/2023.
//

import Foundation

struct Neighborhoods : Codable {
    let typename : String?
    let name : String?
    let regionId : String?

    enum CodingKeys: String, CodingKey {

        case typename = "__typename"
        case name = "name"
        case regionId = "regionId"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        regionId = try values.decodeIfPresent(String.self, forKey: .regionId)
    }

}

struct Neighborhood : Codable {
    let typename : String?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case typename = "__typename"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}


struct DestinationInfo : Codable {
    let typename : String?
    let distanceFromDestination : DistanceFromDestination?
    let distanceFromMessaging : String?
    let regionId : String?

    enum CodingKeys: String, CodingKey {

        case typename = "__typename"
        case distanceFromDestination = "distanceFromDestination"
        case distanceFromMessaging = "distanceFromMessaging"
        case regionId = "regionId"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        distanceFromDestination = try values.decodeIfPresent(DistanceFromDestination.self, forKey: .distanceFromDestination)
        distanceFromMessaging = try values.decodeIfPresent(String.self, forKey: .distanceFromMessaging)
        regionId = try values.decodeIfPresent(String.self, forKey: .regionId)
    }
}


struct DistanceFromDestination : Codable {
    let typename : String?
    let unit : String?
    let value : Double?

    enum CodingKeys: String, CodingKey {

        case typename = "__typename"
        case unit = "unit"
        case value = "value"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        unit = try values.decodeIfPresent(String.self, forKey: .unit)
        value = try values.decodeIfPresent(Double.self, forKey: .value)
    }

}
