//
//  UserDefaultsManager.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 26/9/2023.
//

//this is a class to store small things for userDefaults including metadata and app settings
import Foundation

class UserDefaultsManager {
    private static let METADATA_KEY = "hotelMetalData"
    private static let PROPERTY_SEARCH_KEY = "hotelPropertySearchAndSettings"
    private static let standard = UserDefaults.standard
    
    //this is a function to save the hotel metadata to user defaults to reduce the numbers of API calls needed.
    static func setMetaData(metaData: MetaDataResponse) {
        //encodes it to json format
        let encodedMetaData = try! JSONEncoder().encode(metaData)
        
        //saves it to userDefaults
        standard.setValue(encodedMetaData, forKey: METADATA_KEY)
    }
    
    //retrieves the metadata from user defaults without having to call the API
    //if there is no data in user defaults, it call the api.
    static func readMetadata() -> MetaDataResponse? {
        if let haveData = standard.data(forKey: METADATA_KEY) {
            //decodes the JSON
            let data = try? JSONDecoder().decode(MetaDataResponse.self, from: haveData)
                return data
        }
        return nil
    }
    
    //saves the property search stuff to user defaults
    public static func savePropertySearchPrefernces(propertySearchPreferences propertyRequest: PropertyListRequest) {
        //encodes it to JSON
        let encodedPropertySearch = try! JSONEncoder().encode(propertyRequest)
        //saves it to user defaults
        standard.setValue(encodedPropertySearch, forKey: PROPERTY_SEARCH_KEY)
    }
    
    //loads it from user defaults
    public static func loadPropertySearchData() -> PropertyListRequest? {
        if let haveData = standard.data(forKey: PROPERTY_SEARCH_KEY) {
            let data = try? JSONDecoder().decode(PropertyListRequest.self, from: haveData)
            return data
        }
        return nil
    }
    
    //this is a function to remove the preferences from user default and resets it to the default one.
    static func removePreferences() {
        standard.removeObject(forKey: PROPERTY_SEARCH_KEY)
    }
}
