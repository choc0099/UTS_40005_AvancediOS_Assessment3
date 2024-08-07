//
//  InSessionView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 14/10/2023.
//

import SwiftUI

//like on my previous assignment SoulDates, this is a session view when the user is logged in to the app.
struct InSessionView: View {
    @EnvironmentObject var hotelMain: HotelBrowserMainViewModel
    @EnvironmentObject var hotelFavesVM: HotelFavouritesViewModel
    @EnvironmentObject var propertyHistoryVM: PropertyHistoryViewModel
    //this is used to track selected tab.
    @State var selectedTab: Int = 0
    var body: some View {
        
        TabView(selection: $selectedTab) {
            SearchView().tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }.tag(0)
            HotelFavouritesView().tabItem {
                Label("Favourites", systemImage: "heart" )
            }.tag(1)
            PropertyHistoryView().tabItem {
                Label("Recents", systemImage: "clock.fill")
            }.tag(2)
            SettingsView().tabItem {
                Label("Settings", systemImage: "gearshape.fill")
            }
        }.accentColor(Color(UIColor.systemBlue))
        .onAppear {
            DispatchQueue.main.async {
                Task {
                    //loads the hotel metaData
                    hotelMain.initialiseMetaData()
                    //refreshes the view models for favourites and history data
                    propertyHistoryVM.fetchHistory()
                    hotelFavesVM.fetchFavourites()
                }
                
            }
            
        }
    }
}

#Preview {
    InSessionView()
}
