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
    
    var body: some View {
        List{
            ForEach(roomSearchVM.propertyResoults) {
                property in
                HotelPropertyRow(name: property.name, formattedPrice: property.price.lead.formatted, formattedDiscount: property.price.strikeOut?.formatted)
            }
        }
    }
}

#Preview {
    HotelRoomsResultsListView(roomSearchVM: HotelPropertySearchViewModel(), regionId: "", regionCoordinates: Coordinates(lat: -1.12344, long: -1.234905123))
}
