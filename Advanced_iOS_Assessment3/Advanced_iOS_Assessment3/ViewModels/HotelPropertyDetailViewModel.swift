//
//  HotelPropertyDetailViewModel.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 2/10/2023.
//

import Foundation

class HotelPropertyDetailViewModel: ObservableObject {
    @Published var description: String = ""
    @Published var propertyDetails: PropertyDetalResponse?
    
    //returns the property request object that converts it to JSON.
    func convertToObject(propertyId: String, metaData: MetaDataResponse) -> PropertyContentRequest {
        return PropertyContentRequest(propertyId: propertyId, eapid: Int(metaData.australia.eapId), locale: metaData.australia.supportedLocales[0].hotelSiteLocaleIdentifier, currency: "AUD", siteId: metaData.australia.siteId)
    }
    
    //handles the request
    
}
