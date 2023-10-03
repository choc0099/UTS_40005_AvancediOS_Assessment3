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
    /*
    var propertyDetailsText: Dictionary<String, [String]> {
        if let sections = propertyInfo?.contentSection?.aboutThisProperty?.sections {
            
        }
    }*/
    
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
    
    func fetchPropertyDetails(propertyId: String, metaData: MetaDataResponse) async {
        do {
            let request = try processRequest(propertyId: propertyId, metaData: metaData)
            
            //decodes the JSON response
            let (data,_) = try await URLSession.shared.data(for: request)
            
            let propertyDetailsResponse = try JSONDecoder().decode(PropertyDetalResponse.self, from: data)
            
            DispatchQueue.main.async {
                self.propertyInfo = propertyDetailsResponse.propertyData?.propertyInfo
            }
        } catch {
            print(error.localizedDescription)
            print(error)
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
