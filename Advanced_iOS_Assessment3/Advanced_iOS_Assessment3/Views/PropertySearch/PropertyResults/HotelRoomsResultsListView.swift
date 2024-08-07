//
//  HotelRoomsResultsView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 27/9/2023.
//

import SwiftUI

struct HotelRoomsResultsListView: View {
    @ObservedObject var roomSearchVM: HotelPropertySearchViewModel
    @State var regionId: String
    @State var regionCoordinates: Coordinates
    //this view lists the hotels that is fetched from the api for the user to view.
    var body: some View {
        List{
            ForEach(roomSearchVM.propertyResults) {
                property in
                NavigationLink(destination: PropertyDetailsProcessingView(propertyId: property.hotelId, price: property.price.lead.amount, totalAdults: roomSearchVM.totalAdults, totalChildren: roomSearchVM.totalChildren, numbersOfNights: roomSearchVM.numberOfNights, numbersOfRooms: roomSearchVM.rooms.count, fromPrevious: true)) {
                    HotelPropertyRow(hotelProperty: property)
                }
                
            }
        }
    }
}

#Preview {
    HotelRoomsResultsListView(roomSearchVM: HotelPropertySearchViewModel(), regionId: "", regionCoordinates: Coordinates(lat: -1.12344, long: -1.234905123))
}
