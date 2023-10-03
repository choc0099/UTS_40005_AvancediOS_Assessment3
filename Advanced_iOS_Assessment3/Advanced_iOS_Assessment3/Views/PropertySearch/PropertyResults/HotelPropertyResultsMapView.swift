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
                    NavigationLink(destination: PropertyDetailsProcessingView(propertyId: marker.name)) {
                        VStack {
                            HotelImageView(propertyImage: marker.property.propertyImage, imageSize: 50, mapMode: true)
                            Text(marker.name).font(.caption).background(.background).foregroundColor(.primary).bold().frame(width: 125).padding(.horizontal, 2)
                        }
                    }
                   
                }
            }.onAppear {
                //loads the annotations
                //zooms in the map automatically after the view has been tapped.
                withAnimation(.easeInOut(duration: 1.0)) {
                    currentCoordinates.span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                }
                roomSearchVM.convertToAnnotations()
                
                
            }
        }
    }
}

#Preview {
    HotelPropertyResultsMapView(roomSearchVM: HotelPropertySearchViewModel(), currentCoordinates: MKCoordinateRegion())
}
