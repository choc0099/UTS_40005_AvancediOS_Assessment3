//
//  PropertyContentRequest.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 1/10/2023.
//

import Foundation

//this is used for encoding to JSON for a POST request.
struct PropertyContentRequest: Hashable, Encodable {
    let propertyId: String
    let eapid: Int?
    let locale: String?
    let currency: String
    let siteId: Int?
    
    enum CodingKeys: String, CodingKey {
        case propertyId
        case eapid
        case locale
        case currency
        case siteId
    }
    
    init(propertyId: String, eapid: Int?, locale: String?, currency: String, siteId: Int?) {
        //converts the propertyId to a string that is used for JSON
        self.propertyId = propertyId
        self.locale = locale
        self.eapid = eapid
        self.currency = currency
        self.siteId = siteId
    }
}

