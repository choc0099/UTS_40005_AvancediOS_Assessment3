//
//  HotelFavouritesView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 5/10/2023.
//

import SwiftUI

struct HotelFavouritesView: View {
    @EnvironmentObject var hotelFavsVM: HotelFavouritesViewModel
    var body: some View {
        
        NavigationStack {
            if hotelFavsVM.status == .active {
                List {
                    ForEach(hotelFavsVM.favourites) {
                        favourite in
                        NavigationLink {
                            PropertyDetailsProcessingView(propertyId: favourite.hotelId)
                        } label: {
                            HotelFavouritesRow(favourite: favourite)
                        }.swipeActions {
                            Button("Delete", role: .destructive) {
                                hotelFavsVM.removeFromFavourites(propertyId: favourite.hotelId)
                                //refreshes the favourites list
                                hotelFavsVM.fetchFavourites()
                            }
                        }
                        
                    }
                }
                
            }
            else {
                //displays messages to the user.
                ErrorView(errorStatus: hotelFavsVM.status)
            }
            //alert is shown if the favourites failed to delete.
        }.alert(isPresented: $hotelFavsVM.showAlert, content: {
            Alert(
                title: Text(hotelFavsVM.alertTitle),
                message: Text(hotelFavsVM.alertMessage)
            )
        })
    }
}

#Preview {
    HotelFavouritesView()
}
