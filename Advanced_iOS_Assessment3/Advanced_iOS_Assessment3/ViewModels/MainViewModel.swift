//
//  MainViewModel.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 18/9/2023.
//

import Foundation

class HotelBrowserMainViewModel: ObservableObject {
    @Published var searchResults = [SearchResult]()
    
    //these are the headers to initialise the API request
    let headers = [
        "X-RapidAPI-Key" : "fdc2564bbemshd3b062f571b3b8cp173b6ejsn78fc48e2f6b0",
        "X-RapidAPI-Host" : "hotels4.p.rapidapi.com"
    ]
    
    var token: String? //used for auth requests
    var transactionId: Int = 1
    
    //this is a function the will return an URL Request
    func hotelApi(_ path: String) -> URLRequest {
        
        let apiUrl = "http://hotels4.p.rapidapi.com"
        
        var url = URL(string: apiUrl + path)
        
        var request = URLRequest(url: url!)
        //puts the header into the url request
        request.allHTTPHeaderFields = headers
        return request
    }
    
    func loadRegions() async {
        //gets the request with the location search
        //i have hard coded the query strings for now.
        var request = hotelApi("/locations/v3/search?q=sydney&locale-en_AU")
        
        do {
            //sends the url request
            let (data, _) = try await URLSession.shared.data(for: request)
            
            //decodes the JSON response
            let response = try JSONDecoder().decode(SearchResponse.self, from: data)
            
            //adds it to the view model structs so it can be displayed in the UI
            searchResults = response.searchResults
        }
        catch {
            print("Something went wrong \(error)")
        }
        
    }
}
