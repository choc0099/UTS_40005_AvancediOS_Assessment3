//
//  HotelFavouritesView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 5/10/2023.
//

import SwiftUI

struct HotelFavouritesView: View {
    @StateObject var hotelFavsVM: HotelFavouritesViewModel = HotelFavouritesViewModel()
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(hotelFavsVM.favourites) {
                    favourite in
                    NavigationLink {
                        PropertyDetailsProcessingView(propertyId: favourite.hotelId)
                    } label: {
                        HotelFavouritesRow(favourite: favourite)
                    }.swipeActions {
                        Button("Delete", role: .destructive) {
                            try! hotelFavsVM.removeFromFavourites(propertyId: favourite.hotelId)
                        }
                    }
                    
                }
            }
        }
    }
}

#Preview {
    HotelFavouritesView()
}
