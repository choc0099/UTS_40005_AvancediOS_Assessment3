//
//  HotelPropertyResultsMapView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 28/9/2023.
//

import SwiftUI
import MapKit

struct HotelPropertyResultsMapView: View {
    @ObservedObject var roomSearchVM: HotelPropertySearchViewModel
    @State var region: NeighborhoodSearchResult
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    HotelPropertyResultsMapView(roomSearchVM: HotelPropertySearchViewModel(), region: NeighborhoodSearchResult(gaiaId: "."))
}
