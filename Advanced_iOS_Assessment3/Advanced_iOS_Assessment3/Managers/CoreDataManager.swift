//
//  CoreDataManager.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 29/9/2023.
//

import Foundation
import CoreData

enum searchType: String {
    case hotel, region
}

//this is a struct to manage CoreData accross multiple ViewModels
//for this assessment, I only used CoreData to store query search history for the search view.
class CoreDataManager {
    private static var viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext
    private static var searchHistoryResults: NSFetchRequest<SearchHistory>  = SearchHistory.fetchRequest()
    
    //this saves the search query to CoreData so that when the next time they open the app, they can access the search history. It also reduces one api calls to save costs.
    static func saveNeighbourhoodSearch(searchType: searchType, cameFromHistory: Bool, regionId: String, regionName: String, regionCoordinates: Coordinates) {
        //this will prevent it from being saved to CoreData if the user has navigated from the History view but will save if it is from a live search results.
        if !cameFromHistory && !regionAlreadyExists(regionName: regionName){
            let context = viewContext
            let searchHistory = SearchHistory(context: context)
            searchHistory.userId = FirebaseAuthManager.authRef.currentUser?.uid
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
                if region.regionName == regionName && region.userId == FirebaseAuthManager.authRef.currentUser?.uid ?? ""{
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
        //these are multiple predicates getting involved
        let regionNamePred = NSPredicate(format: "regionName == %@", regionName)
        let userIdPred = NSPredicate(format:"userId == %@", FirebaseAuthManager.authRef.currentUser?.uid ?? "")
        let compoundPred = NSCompoundPredicate(andPredicateWithSubpredicates: [regionNamePred, userIdPred])
        newFetchRequest.predicate = compoundPred
        
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
    
    //this will clear all search history that is allocated to the user
    static func clearAllSearchHistory() throws {
        let newFetchRequest: NSFetchRequest<SearchHistory> = SearchHistory.fetchRequest()
        //queries the predicate to delete all search history only allocated to that specific user.
        newFetchRequest.predicate = NSPredicate(format: "userId == %@", FirebaseAuthManager.authRef.currentUser?.uid ?? "")
        
        let searchHistorys = try viewContext.fetch(newFetchRequest)
        for historyItem in searchHistorys {
            //deletes the history item.
            viewContext.delete(historyItem)
        }
        
        //saves it to the context
        try viewContext.save()
    }
}
