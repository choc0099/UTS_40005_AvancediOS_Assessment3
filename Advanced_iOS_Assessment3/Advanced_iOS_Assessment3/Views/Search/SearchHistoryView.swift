//
//  SearchHistoryView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 29/9/2023.
//

import SwiftUI

struct SearchHistoryView: View {
    
    //handles stored data persistnace from CoreData to display search history items to the user.
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var hotelMain: HotelBrowserMainViewModel
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \SearchHistory.dateSearched, ascending: false)],
        predicate: NSPredicate(format: "userId == %@", FirebaseAuthManager.authRef.currentUser?.uid ?? ""),
        animation: .default)
    private var searchHistory: FetchedResults<SearchHistory>
    
    var body: some View {
        if !searchHistory.isEmpty {
            List{
                ForEach(searchHistory) {
                    historyItem in
                    //individual parameters are called here.
                    NavigationLink(destination: HotelPropertySearchView(isFromHistory: true, regionId: historyItem.regionId ?? "", regionName: historyItem.regionName ?? "", regionCoordinates: Coordinates(lat: historyItem.regionCoordinates?.latitude ?? 0, long: historyItem.regionCoordinates?.longitude ?? 0))){
                        Text(historyItem.regionName ?? "")
                        
                    }
                   
                }.onDelete(perform: deleteItems)
            }
        } else {
            ErrorView(errorStatus: .welcome)
        }
        
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { searchHistory[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                print("Unable to delete this search history")
            }
        }
    }
}

#Preview {
    SearchHistoryView()
}
