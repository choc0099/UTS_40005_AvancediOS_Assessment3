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
    //this gets the map coordinate information from the object
    @State var currentCoordinates: MKCoordinateRegion
    
    var body: some View {
        Text("")
        Map(coordinateRegion: $currentCoordinates)
    }
}

#Preview {
    HotelPropertyResultsMapView(roomSearchVM: HotelPropertySearchViewModel(), currentCoordinates: MKCoordinateRegion())
}
