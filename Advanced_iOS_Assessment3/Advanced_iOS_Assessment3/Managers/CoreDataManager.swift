//
//  CoreDataManager.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 29/9/2023.
//

import Foundation
import CoreData

//this is a struct to manage CoreData accross multiple ViewModels
class CoreDataManager {
    private static var viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext
    
    static func saveNeighbourhoodSearch(regionId: String, regionName: String, regionCoordinates: Coordinates) {
        let context = viewContext
        let searchHistory = SearchHistory(context: context)
        searchHistory.regionName = regionName
        searchHistory.regionId = regionId
        searchHistory.dateSearched = Date()
        searchHistory.regionCoordinates?.latitude = regionCoordinates.latitude
        searchHistory.regionCoordinates?.longitude = regionCoordinates.longitude
        
        //saves it to core data
        do {
            try context.save()
            print("Search history saved to CoreData.")
        }
        catch {
            print("Error saving context, \(error)")
        }
    }
}
