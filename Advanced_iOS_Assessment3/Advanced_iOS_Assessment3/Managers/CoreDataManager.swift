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
    
    static func saveNeighbourhoodSearch(neighbourhoodResult: NeighborhoodSearchResult) {
        let context = viewContext
        let searchHistory = SearchHistory(context: context)
        searchHistory.regionId = neighbourhoodResult.gaiaId
        searchHistory.dateSearched = Date()
        searchHistory.regionCoordinates?.latitude = neighbourhoodResult.coordinates.latitude
        searchHistory.regionCoordinates?.longitude = neighbourhoodResult.coordinates.longitude
        
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
