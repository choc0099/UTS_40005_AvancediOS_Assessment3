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
    private static var searchHistoryResults: NSFetchRequest<SearchHistory>  = SearchHistory.fetchRequest()
    
    static func saveNeighbourhoodSearch(cameFromHistory: Bool, regionId: String, regionName: String, regionCoordinates: Coordinates) {
        //this will prevent it from being saved to CoreData if the user has navigated from the History view but will save if it is from a live search results.
        if !cameFromHistory && !regionAlreadyExists(regionName: regionName){
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
    //checks if the regionId is already exists on the persistance storage, if it exists, it will only update the date.
    static private func regionAlreadyExists(regionName: String) -> Bool {
        do {
            //fetches the region data stored.
            let regions = try viewContext.fetch(searchHistoryResults)
            for region in regions {
                if region.regionName == regionName {
                    //updates the date to get search date.
                    try updateRegion(regionName: regionName)
                    return true
                }
            }
        } catch {
            print("Unable to perform actions.")
        }
        return false
    }
    
    //this is a helper function specifically used to update the search date so it can show up on from the newests one that has been searched.
    static private func updateRegion(regionName: String)  throws {
        //creates a new fetch request to find the region id.
        let newFetchRequest: NSFetchRequest<SearchHistory> = SearchHistory.fetchRequest()
        newFetchRequest.predicate = NSPredicate(format: "regionName == %@", regionName)
        
        let region = try viewContext.fetch(newFetchRequest).first
        //checks if it is found, this is used for debugging.
        guard region != nil else {
                print("Unable to update this region \(regionName).")
                return
        }
                
        
        //updates the date
        region?.dateSearched = Date()
        
        //saves the context
        try viewContext.save()
        print("Aate on existing search history is updated.")
    
        
    }
}
