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
        if !cameFromHistory && !regionAlreadyExists(regionId: regionId){
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
    static private func regionAlreadyExists(regionId: String) -> Bool {
        do {
            //fetches the region data stored.
            let regions = try viewContext.fetch(searchHistoryResults)
            for region in regions {
                if region.regionId == regionId {
                    //updates the date to get search date.
                    try updateRegion(regionId: regionId)
                    return true
                }
            }
        } catch {
            print("Unable to perform actions.")
        }
        return false
    }
    
    static private func updateRegion(regionId: String)  throws {
        searchHistoryResults.predicate = NSPredicate(format: "regionId == %d", regionId)
        
        let region = try viewContext.fetch(searchHistoryResults)
        let updatedRegion = region.first
        
        //updates the date
        updatedRegion?.dateSearched = Date()
        
        //saves the context
        try viewContext.save()
    
        
    }
}
