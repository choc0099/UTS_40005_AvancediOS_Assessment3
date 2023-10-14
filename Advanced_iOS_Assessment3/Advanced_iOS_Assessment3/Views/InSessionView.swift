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
    var body: some View {
        TabView {
            SearchView().tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }.tag(0)
            HotelFavouritesView().tabItem {
                Label("Favourites", systemImage: "heart.fill")
            }.tag(1)
            PropertyHistoryView().tabItem {
                Label("Recents", systemImage: "clock.fill")
            }.tag(2)
            SettingsView().tabItem {
                Label("Settings", systemImage: "gearshape.fill")
            }
        }.onAppear {
            //loads the hotel metaData
            hotelMain.initialiseMetaData()
        }
    }
}

#Preview {
    InSessionView()
}
