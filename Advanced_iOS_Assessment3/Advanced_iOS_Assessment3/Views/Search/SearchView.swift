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
                    }
                    
                }
            }.padding().background(Color(.systemGray6))
                .cornerRadius(10)
                .padding()
            Group { //the group property is used to add more views based on different conditions.
                if hotelMain.searchStatus == .active {
                  SearchResultsView()
                } else if hotelMain.searchStatus == .welcome {
                   SearchHistoryView()
                } else {
                    VStack(spacing: 10) {
                        if hotelMain.searchStatus == .loading {
                            ProgressView()
                        }
                        else {
                            //displays messages to the user including error messages.
                            ErrorView(errorStatus: hotelMain.searchStatus)
                        }
                    }.frame(maxHeight: .infinity)
                }
            }.navigationTitle("Search").navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).environmentObject(HotelBrowserMainViewModel())
    }
}
