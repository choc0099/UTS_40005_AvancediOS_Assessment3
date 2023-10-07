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
        List {
            ForEach(hotelFavsVM.favourites) {
                favourite in
                //Text(favourite.hotelName)
                HotelFavouritesRow(favourite: favourite)
            }
        }.onAppear(perform: {
            //loads the favourites from DB
            Task {
                await hotelFavsVM.fetchFavourites()
            }
            
            print("Numbers of loaded favourites \(hotelFavsVM.favourites.count)")
        })
    }
}

#Preview {
    HotelFavouritesView()
}
