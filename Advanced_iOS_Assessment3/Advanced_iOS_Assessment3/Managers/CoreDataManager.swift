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
    
    static func saveNeighbourhoodSearch(cameFromHistory: Bool, regionId: String, regionName: String, regionCoordinates: Coordinates) {
        let context = viewContext
        let searchHistory = SearchHistory(context: context)
        searchHistory.regionName = regionName
        searchHistory.regionId = regionId
        searchHistory.dateSearched = Date()
        
        //saves location coordinates data
        let coordinates = RegionCoordinates(context: context)
        coordinates.latitude = regionCoordinates.latitude
        coordinates.longitude = regionCoordinates.longitude
        
        //sets the relationship between searchHistory and coodinates
        searchHistory.regionCoordinates = coordinates
        
        //this will prevent it from being saved to CoreData if the user has navigated from the History view but will save if it is from a live search results.
        if !cameFromHistory {
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
}
