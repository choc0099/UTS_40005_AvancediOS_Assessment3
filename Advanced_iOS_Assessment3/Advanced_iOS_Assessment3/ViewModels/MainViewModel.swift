//
//  MainViewModel.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 18/9/2023.
//

import Foundation

class HotelBrowserMainViewModel: ObservableObject {
    @Published var hotelSearchResults = [HotelSearchResult]()
    
    //these are the headers to initialise the API request
    let headers = [
        "X-RapidAPI-Key": "fdc2564bbemshd3b062f571b3b8cp173b6ejsn78fc48e2f6b0",
        "X-RapidAPI-Host": "hotels4.p.rapidapi.com"
    ]


    
    //this is a function the will return an URL Request
    func hotelApi(_ path: String) -> URLRequest {
        
        let apiUrl = "https://hotels4.p.rapidapi.com"
        
        var url = URL(string: apiUrl + path)! as URL
        
        var request = URLRequest(url: url as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        //puts the header into the url request
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        return request
    }
    
    @MainActor
    func loadRegions() async {
        //gets the request with the location search
        //i have hard coded the query strings for now.
        var request = hotelApi("/locations/v3/search?q=Sydney&locale=en_AU&langid=3081&siteid=300000035")
        do {
            //sends the url request
            let (data, _) = try await URLSession.shared.data(for: request)
            
            //decodes the JSON response
            let response = try JSONDecoder().decode(SearchResponse<HotelSearchResult>.self, from: data)
            
            DispatchQueue.main.async {
                //adds it to the view model structs so it can be displayed in the UI
                if let haveSearchResults = response.searchResults {
                    self.hotelSearchResults = haveSearchResults
                    for result in self.hotelSearchResults {
                        print("\(result.id), \(result.coordinates.latitude)")
                    }
                }
                
               
            }
        }
        catch {
            print("\(error.localizedDescription)")
            print(error)
        }
        
    }
    
    func initialiseSession(request: URLRequest) -> URLSessionDataTask {
        let session = URLSession.shared
        
        let datatask = session.dataTask(with: request)
        return datatask
    }
}
