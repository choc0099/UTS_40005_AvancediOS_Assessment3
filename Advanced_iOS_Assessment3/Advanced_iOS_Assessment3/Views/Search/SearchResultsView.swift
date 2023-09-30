//
//  SearchResultsView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 29/9/2023.
//

import SwiftUI

struct SearchResultsView: View {
    @EnvironmentObject var hotelMain: HotelBrowserMainViewModel
    
    var body: some View {
        List {
            Section("Regions and Places") {
                ForEach(hotelMain.regionSearchResults) {
                    region in
                    if let haveGaiaId = region.gaiaId {
                        NavigationLink {
                            HotelPropertySearchView(isFromHistory: false, regionId: haveGaiaId, regionName: region.regionNames.fullName, regionCoordinates: region.coordinates)
                        } label: {
                            Text("\(region.regionNames.fullName)")
                        }
                    }
                }
            }
            
            Section("Hotel Suggestions") {
                ForEach(hotelMain.hotelSearchResults) { hotel in
                    if let haveHotelId = hotel.hotelId {
                        if hotel.hotelAddress != nil {
                            NavigationLink(destination: HotelPropertySearchView(isFromHistory: false, regionId: haveHotelId, regionName: hotel.regionNames.fullName, regionCoordinates: hotel.coordinates)) {
                                Text(hotel.regionNames.fullName)
                            }
                            
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SearchResultsView()
}
