//
//  HotelPropertyDetailViewModel.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 2/10/2023.
//

import Foundation

class HotelPropertyDetailViewModel: ObservableObject {
    @Published var description: String = ""
    @Published var propertyInfo: PropertyInfo?
    @Published var status: HotelStatus = .loading
    @Published var isFavourite: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    
    //this is a computed property that will return the description of the hotel by unwraping multiple optinal values as not every hotel might contatin this.
    var propertyDescription: String? {
        //there will be nested if let loops to safely unwrap each optional values to get the description of the hotel property.
        //i have checked that the description is located on index zero of the section arrays.
        if let sections = propertyInfo?.contentSection?.aboutThisProperty?.sections {
            if let subSection = sections[0].bodySubSections {
                if let elements = subSection[0].elements {
                    if let items = elements[0].items {
                        if let haveText = items[0].content?.text {
                            return haveText
                        }
                    }
                }
            }
        }
        return nil
    }
    
    var hotelName: String {
        return propertyInfo?.summary.name ?? ""
    }
    
    //returns the property request object that converts it to JSON.
    func convertToObject(propertyId: String, metaData: MetaDataResponse) -> PropertyContentRequest {
        return PropertyContentRequest(propertyId: propertyId, eapid: Int(metaData.australia.eapId), locale: metaData.australia.supportedLocales[0].hotelSiteLocaleIdentifier, currency: "AUD", siteId: metaData.australia.siteId)
    }
    
    //handles the request
    func processRequest(propertyId: String, metaData: MetaDataResponse) throws -> URLRequest {
        var urlComp = URLComponents(string: HotelAPIManager.apiUrl)!
        urlComp.path = HotelAPIManager.endPoints["propertyDetail"]!
        var request = try HotelAPIManager.hotelApi(urlStuffs:  urlComp )
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(convertToObject(propertyId: propertyId, metaData: metaData))
        return request
    }
    
    @MainActor
    func fetchPropertyDetails(propertyId: String, metaData: MetaDataResponse) async {
        do {
            let request = try processRequest(propertyId: propertyId, metaData: metaData)
            
            //decodes the JSON response
            let (data,_) = try await URLSession.shared.data(for: request)
            
            let propertyDetailsResponse = try JSONDecoder().decode(PropertyDetalResponse.self, from: data)
            
            DispatchQueue.main.async  {
                self.propertyInfo = propertyDetailsResponse.propertyData.propertyInfo
                self.status = .active
            }
        } catch URLError.notConnectedToInternet {
            self.status = .offline
            print("You are offline.")
        } catch URLError.timedOut  {
            self.status = .requestTimeOut
            print("Request timed out.")
        }
        catch {
            self.status = .unkown
            print(error.localizedDescription)
            print(error)
        }
      
    }
    
    //this will add the property that the user was viewing to favourites
    //it will also save it to FireBase database
    func addToFavourites() {
        if let property = propertyInfo {
            if let image = propertyInfo?.propertyGallery?.images {
                let favourite = HotelFavourite(hotelId: property.summary.id, hotelName: property.summary.name, hotelAddress: property.summary.location.address.addressLine, imageUrl: image[0].image?.url ?? "", imageDescription: image[0].image?.description)
                //saves it to the database
                FirebaseManager.saveFavouriteToDB(favourite: favourite) .done {
                    //updates the favourite status
                    self.isFavourite = true
                    print("Added to favourites")
                } .catch { error in
                    self.showAlert = true
                    self.alertTitle = "Unable to add to favourites"
                    self.alertMessage = "Something went wrong when trying to add to favourites"
                    print(error)
                    print(error.localizedDescription)
                }
            }
            
        }
    }
    
    //a function to check if the favourites exists
    
    func checkFavourite()  {
        
        if let propertyId = propertyInfo?.summary.id {
            FirebaseManager.getSpecificFavourite(propertyId: propertyId)
            .done { favourite in
                if favourite != nil {
                    self.isFavourite = true
                    print("This property is already in favourites")
                }
                else {
                    self.isFavourite = false
                    print("This property is not added in favourites")
                }
                
            }
            .catch { error in
                //sets it to nil when an error occurs so the app does not crash.
                self.isFavourite = false
                print(error)
                print(error.localizedDescription)
            }
        }
        
       
    }
    
    //managed favourites
    //this function will be used on the view side whether it should be removed or added to the favourites based if it already exist or not.
    func manageFavourite()  {
        //checks if it is already added onto favourite
            if isFavourite {
                removeFromFavourites()
            }
            else {
                addToFavourites()
            }
    }
    
    //this function will remove a hotel from favourites
    private func removeFromFavourites() {
        if let propertyId = propertyInfo?.summary.id {
            FirebaseManager.removeFavouriteFromDB(propertyId: propertyId) .done {
                self.isFavourite = false
            } .catch { error in
                self.showAlert = true
                self.alertTitle = "Unable to remove from favourites."
                self.alertMessage = "Something went wrong when removing from favourites"
                print(error)
                print(error.localizedDescription)
            }
            
        }
    }
    
    //saves the property history
    func savePropertyHistory(numbersOfNights: Int, totalAdults: Int, totalChildren: Int, price: Double) {
        //declares an object
        if let propertyInfo = propertyInfo {
            let historyItem = PropertyHistory(hotelId: propertyInfo.summary.id, hotelName: propertyInfo.summary.name, hotelAddress: propertyInfo.summary.location.address.addressLine, imageUrl: "abc", numbersOfNights: numbersOfNights, numbersOfRooms: 0, totalAdults: totalAdults, totalChildren: totalChildren, price: price)
            //saves it to the DB
            FirebaseManager.addPropertyHistory(history: historyItem)
                .catch { error in
                    print(error)
                    print(error.localizedDescription)
                }
        }
        
    }
    
    /*
    func loadDescriptions() {
        /*if let sections = propertyDetails?.contentSection?.aboutThisProperty?.sections {
            for section in sections {
                
            }
        }*/
        
        //description = propertyDetails?.contentSection?.aboutThisProperty?.sections[0]?.bodySubSections[0]?.elements[0]?.items[0]?.content?.text
    }*/
}
