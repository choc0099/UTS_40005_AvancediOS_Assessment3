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
            Section("Regions and Neighbourhoods") {
                ForEach(hotelMain.regionSearchResults) {
                    region in
                    if region.type != "HOTEL" {
                        NavigationLink {
                            HotelPropertySearchView(regionId: region.gaiaId!, regionName: region.regionNames.fullName, regionCoordinates: region.coordinates)
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
    }
}

#Preview {
    SearchResultsView()
}
