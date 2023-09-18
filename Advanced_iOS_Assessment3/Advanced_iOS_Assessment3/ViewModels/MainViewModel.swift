//
//  MainViewModel.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 18/9/2023.
//

import Foundation

class HotelBrowserMainViewModel: ObservableObject, Codable {
    
    //these are the headers to initialise the API request
    let headers = [
        "API_KEY" : "fdc2564bbemshd3b062f571b3b8cp173b6ejsn78fc48e2f6b0",
        "API_HOST" : "hotels4.p.rapidapi.com"
    ]
}
