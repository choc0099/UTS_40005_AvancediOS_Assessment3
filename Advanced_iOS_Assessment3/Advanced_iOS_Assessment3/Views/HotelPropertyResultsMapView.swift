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
        Group {
            Map(coordinateRegion: $currentCoordinates, annotationItems: roomSearchVM.hotelResultsAnnotations) {
                marker in
                MapAnnotation(coordinate: marker.coordinate) {
                    VStack {
                        Image(systemName: "building.fill")
                        Text(marker.name).font(.caption).background(.background).foregroundColor(.primary).bold().padding(.horizontal, 2)
                    }
                }
            }.onAppear {
                //loads the annotations
                roomSearchVM.convertToAnnotations()
            }
        }
    }
}

#Preview {
    HotelPropertyResultsMapView(roomSearchVM: HotelPropertySearchViewModel(), currentCoordinates: MKCoordinateRegion())
}
