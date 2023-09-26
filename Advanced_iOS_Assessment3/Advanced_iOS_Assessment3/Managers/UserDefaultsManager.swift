//
//  UserDefaultsManager.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 26/9/2023.
//

//this is a class to store small things for userDefaults including metadata and app settings
import Foundation

class UserDefaultsManager {
    static let METADATA_KEY = "hotelMetalData"
    static let standrad = UserDefaults.standard
    
    //this is a function to save the hotel metadata to user defaults to reduce the numbers of API calls needed.
    static func setMetaData(metaData: MetaDataResponse) {
        //encodes it to json format
        let encodedMetaData = try! JSONEncoder().encode(metaData)
        
        //saves it to userDefaults
        standrad.setValue(encodedMetaData, forKey: METADATA_KEY)
    }
    
    //retrieves the metadata from user defaults without having to call the API
    //if there is no data in user defaults, it call the api.
    static func readMetadata() -> MetaDataResponse? {
        if let haveData = standrad.data(forKey: METADATA_KEY) {
            //decodes the JSON
            let data = try? JSONDecoder().decode(MetaDataResponse.self, from: haveData)
                return data
        }
        return nil
    }
}
