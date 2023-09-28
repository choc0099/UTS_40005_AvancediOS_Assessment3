//
//  HotelRoomsResultsView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 27/9/2023.
//

import SwiftUI

struct HotelRoomsResultsListView: View {
    @ObservedObject var roomSearchVM: HotelPropertySearchViewModel
    var region: NeighborhoodSearchResult?
    
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
    HotelRoomsResultsListView(roomSearchVM: HotelPropertySearchViewModel())
}
