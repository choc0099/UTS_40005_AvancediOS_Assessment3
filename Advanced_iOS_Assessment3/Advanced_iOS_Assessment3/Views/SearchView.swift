//
//  SearchView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 26/9/2023.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var hotelMain: HotelBrowserMainViewModel
    @State var searchText: String = ""
    @State var errorText: String = "" //displays a message to the user.
    
    //handles stored data persistnace from CoreData to display search history items to the user.
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \SearchHistory.regionName, ascending: true)],
        animation: .default)
    private var searchHistory: FetchedResults<SearchHistory>
    var body: some View {
        NavigationStack {
            //this is for the search fields to search for a query including hotels and regions
            HStack(spacing: 5) {
                Image(systemName: "magnifyingglass")
                TextField("Search", text: $searchText).onSubmit {
                    //sets the search status to loading mode
                    hotelMain.searchStatus = .loading
                    Task {
                        //loads the list of hotels using the api
                        await hotelMain.loadRegions(query: searchText)
                        //clears the search field after submission.
                        searchText = ""
                        //updates the error text if it was to occur
                        updateText()
                    }
                    
                }
            }.padding().background(Color(.systemGray6))
                .cornerRadius(10)
                .padding()
            Group { //the group property is used to add more views based on different conditions.
                if hotelMain.searchStatus == .active {
                    List {
                        Section("Regions and Neighbourhoods") {
                            ForEach(hotelMain.regionSearchResults) {
                                region in
                                if region.type != "HOTEL" {
                                    NavigationLink {
                                        HotelPropertySearchView(region: region)
                                    } label: {
                                        Text("\(region.regionNames.fullName)")
                                    }

                                }
                            }
                        }
                        
                        Section("Hotel Suggestions") {
                            ForEach(hotelMain.hotelSearchResults) { hotel in
                                if hotel.type == "HOTEL" {
                                    if hotel.hotelAddress != nil {
                                        
                                        Text(hotel.regionNames.fullName)
                                    }
                                }
                            }
                        }
                    }
                } else if hotelMain.searchStatus == .welcome {
                    List{
                        ForEach(searchHistory) {
                            historyItem in
                            Text(historyItem.regionName ?? "")
                        }.onDelete(perform: deleteItems)
                        
                    }
                }
                else {
                    VStack(spacing: 10) {
                        if hotelMain.searchStatus == .loading {
                            ProgressView()
                        }
                        else {
                            //displays messages to the user including error messages.
                            Text("\(errorText)")
                        }
                    }.frame(maxHeight: .infinity)
                }
            }.onAppear {
                updateText()
            }
        }
    }
    
    func updateText() {
        //adds text depnding on scenarios
        switch(hotelMain.searchStatus) {
        case .welcome:
            errorText = "Welcome to Hotel Browser"
        case .noResults:
            errorText = "No Results Found"
        case .offline:
            errorText = "You are currently offline."
        case .unkown:
            errorText = "Something went wrong!"
        default:
            errorText = ""
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
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).environmentObject(HotelBrowserMainViewModel())
    }
}
