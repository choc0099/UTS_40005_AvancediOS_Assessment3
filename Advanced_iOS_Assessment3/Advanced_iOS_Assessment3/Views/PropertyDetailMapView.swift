//
//  PropertyDetailMapView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 15/10/2023.
//

import SwiftUI
import MapKit

//this is a map view when the the static map image has been pressed.
struct PropertyDetailMapView: View {
    @State var coordinates: MKCoordinateRegion
    var body: some View {
        NavigationStack {
            Map(coordinateRegion: $coordinates)
        }
        
    }
}
