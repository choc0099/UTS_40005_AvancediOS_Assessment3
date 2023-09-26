//
//  MainViewModel.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 18/9/2023.
//

import Foundation

enum APIErrors: Error {
    case invalidUrl
    case noSearchResults
}
//these are the statuses for the search view where it change the UI stuff based on scenarios such as loading and offline
enum HotelStatus {
    case active
    case loading
    case offline
    case noResults
    case welcome
    case unkown
}

class HotelBrowserMainViewModel: ObservableObject {
    @Published var hotelSearchResults = [HotelSearchResult]()
    @Published var regionSearchResults = [NeighborhoodSearchResult]()
    @Published var searchStatus: HotelStatus = .welcome //this is used to display a welcome message when the app launches.
    //these are the headers to initialise the API request
    let headers = [
        "X-RapidAPI-Key": "fdc2564bbemshd3b062f571b3b8cp173b6ejsn78fc48e2f6b0",
        "X-RapidAPI-Host": "hotels4.p.rapidapi.com"
    ]
    //this is a dictonary to store URL path EndPoints.
    let endPoints = [
        "search": "/locations/v3/search",
        "listProperty": "/properties/v2/list"
        //?q=Surry%20Hills&locale=en_AU&langid=3081&siteid=300000035"
    ]
    
    let apiUrl = "https://hotels4.p.rapidapi.com"


    
    //this is a function the will return an URL Request
    func hotelApi(urlStuffs urlComp: URLComponents) throws -> URLRequest {
        if let validURL = urlComp.url {
            var request = URLRequest(url: validURL as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
            //puts the header into the url request
            request.allHTTPHeaderFields = headers
            request.httpMethod = "GET"
            return request
        }
        else {
            throw APIErrors.invalidUrl
        }
    }
    
    @MainActor
    func loadRegions(query q: String) async {
        //gets the request with the location search
        // this is the URL Componemnets that forms a URL
        var urlComp: URLComponents = URLComponents()
        urlComp.host = headers["X-RapidAPI-Host"]!
        urlComp.scheme = "https"
        urlComp.path = endPoints["search"]!
        urlComp.queryItems = [
            URLQueryItem(name: "q", value: q),
            URLQueryItem(name: "locale", value: "en_AU"),
            URLQueryItem(name: "langid", value: "3081"),
            URLQueryItem(name: "siteid", value: "300000035")
        ]
        
        if let haveUrl = urlComp.url {
            print(haveUrl)
        }
        
        do {
            var request = try hotelApi(urlStuffs: urlComp)
            
            //sends the url request
            let (data, _) = try await URLSession.shared.data(for: request)
            
            //decodes the JSON response
            let hotelResponse = try JSONDecoder().decode(SearchResponse<HotelSearchResult>.self, from: data)
            let regionResponse = try JSONDecoder().decode(SearchResponse<NeighborhoodSearchResult>.self, from: data)
            
            DispatchQueue.main.async {
               //a nested do catch block is included on this dispatch queue to throw a custom error if the array is empty.
                do {
                    //adds it to the view model structs so it can be displayed in the UI
                    if let haveSearchResults = hotelResponse.searchResults {
                        self.hotelSearchResults = haveSearchResults
                        for result in self.hotelSearchResults {
                            print("\(result.id), \(result.coordinates.latitude)")
                        }
                    }
                    
                    if let haveRegionResults = regionResponse.searchResults {
                        self.regionSearchResults = haveRegionResults
                    }
                    
                    //checks if there are search results in both models
                    if self.regionSearchResults.isEmpty && self.hotelSearchResults.isEmpty{
                        throw APIErrors.noSearchResults
                    }
                    
                    //tells the view to view the search results
                    self.searchStatus = .active
                } //catches a noSearchResult error if it was thrown.
                catch {
                    //tells the view to display no search results to the user.
                    self.searchStatus = .noResults
                }
            }
            
        }
        catch(APIErrors.noSearchResults)
        {
            //tells the view to display no search results to the user.
            searchStatus = .noResults
        }
        catch(APIErrors.invalidUrl) {
            //displays an sn error message that is explainable to the user
            searchStatus = .unkown
            print("Invalid URL")
        }
        //catches this error if it is offline
        catch(URLError.notConnectedToInternet)
        {
            searchStatus = .offline
            print("You are offline!")
        }
        catch {
            searchStatus = .unkown
            print("\(error.localizedDescription)")
            print(error)
            print("Error: ", type(of: error))
        }
        
    }
    
    func initialiseSession(request: URLRequest) -> URLSessionDataTask {
        let session = URLSession.shared
        
        let datatask = session.dataTask(with: request)
        return datatask
    }
}
