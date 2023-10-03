//
//  HotelAPIManager.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 27/9/2023.
//

//this is a manager class that will handle hotel API requests and endpoints accross different view models.
import Foundation

enum APIErrors: Error {
    case invalidUrl
    case noSearchResults
}

class HotelAPIManager {
    //these are the headers to initialise the API request
    static let headers = [
        "X-RapidAPI-Key": "fdc2564bbemshd3b062f571b3b8cp173b6ejsn78fc48e2f6b0",
        "X-RapidAPI-Host": "hotels4.p.rapidapi.com"
    ]
    //this is a dictonary to store URL path EndPoints.
    static let endPoints = [
        "search": "/locations/v3/search",
        "listProperty": "/properties/v2/list",
        "metaData": "/v2/get-meta-data",
        "propertyDetail": "/properties/v2/detail"
    ]
    
    static let apiUrl = "https://hotels4.p.rapidapi.com"
    
    //this is a function the will return an URL Request
    static func hotelApi(urlStuffs urlComp: URLComponents) throws -> URLRequest {
        if let validURL = urlComp.url {
            var request = URLRequest(url: validURL as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
            //puts the header into the url request
            request.allHTTPHeaderFields = headers
            request.httpMethod = "GET"
            //used for testing and debugging.
            print(validURL)
            
            return request
        }
        else {
            throw APIErrors.invalidUrl
        }
    }
}
