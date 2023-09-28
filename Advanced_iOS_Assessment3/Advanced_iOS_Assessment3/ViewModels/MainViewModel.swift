//
//  MainViewModel.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 18/9/2023.
//

import Foundation


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
    //this is the property to store hotel metadata.
    @Published var metaData: MetaDataResponse?
    
    
    //initialises the hotel metaData
    //will not be using it on the init but to call it from the view
    func initialiseMetaData() {
        //checks if metadata is already stored in userDefaults
        if let metaDataStored = UserDefaultsManager.readMetadata() {
            metaData = metaDataStored
            print("retreiving metadata from user defaults")
            print("Country Code \(metaDataStored.australia.supportedLocales[0].hotelSiteLocaleIdentifier)")
            print("siteId \(metaDataStored.australia.siteId)")
            print("eapId \(metaDataStored.australia.eapId)")
        }
        else {
            Task {
                print("fetching data from the API.")
                await fetchMetaData()
            }
            
        }
    }
    
    @MainActor
    func loadRegions(query q: String) async {
        //gets the request with the location search
        // this is the URL Componemnets that forms a URL
        var urlComp: URLComponents = URLComponents()
        urlComp.host = HotelAPIManager.headers["X-RapidAPI-Host"]!
        urlComp.scheme = "https"
        urlComp.path = HotelAPIManager.endPoints["search"]!
        
        if let haveMetaData = metaData {
            urlComp.queryItems = [
                URLQueryItem(name: "q", value: q),
                URLQueryItem(name: "locale", value: haveMetaData.australia.supportedLocales[0].hotelSiteLocaleIdentifier),
                URLQueryItem(name: "langid", value: "\(haveMetaData.australia.supportedLocales[0].languageIdentifier)"),
                URLQueryItem(name: "siteid", value: "\(haveMetaData.australia.siteId)")
            ]
        }
   
        
        if let haveUrl = urlComp.url {
            print(haveUrl)
        }
        
        do {
            var request = try HotelAPIManager.hotelApi(urlStuffs: urlComp)
            
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
    @MainActor
    //loads the metadata, this is used as a helpter function to initialise the metadata property.
    func fetchMetaData() async {
        //generates the URL
        let apiURL = HotelAPIManager.apiUrl
        var urlComp: URLComponents = URLComponents(string: apiURL)!
        urlComp.path = HotelAPIManager.endPoints["metaData"]!
        do {
            //sends the request via HTTP
            let request = try HotelAPIManager.hotelApi(urlStuffs: urlComp)
            
            //decodes the data and stores it onto the properties.
           let (data, _) = try await URLSession.shared.data(for: request)
            
            //decodes the JSON response
            let response = try JSONDecoder().decode(MetaDataResponse.self, from: data)
            DispatchQueue.main.async {
                //adds it to the view
                self.metaData = response
                //saves it to userDefaults
                UserDefaultsManager.setMetaData(metaData: response)
                
                //this is used to test if meta data is displayed
                if let haveMetaData = self.metaData {
                    print("Country Code \(haveMetaData.australia.countryCode)")
                    print("siteId \(haveMetaData.australia.siteId)")
                    print("eapId \(haveMetaData.australia.eapId)")
                }
                
            }
           
        
        }
        catch(URLError.notConnectedToInternet) {
            //tells the user that they are not connected to the internet.
            searchStatus = .offline
        }
        catch {
            searchStatus = .unkown
            print(error)
            print(error.localizedDescription)
        }
    }
    
    func initialiseSession(request: URLRequest) -> URLSessionDataTask {
        let session = URLSession.shared
        
        let datatask = session.dataTask(with: request)
        return datatask
    }
}
