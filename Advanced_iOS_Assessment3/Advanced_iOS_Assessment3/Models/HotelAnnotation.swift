//
//  HotelAnnotations.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 28/9/2023.
//
import MapKit

import Foundation
//this is a struct that is used to pinpoint hotels on the map with some details.
class HotelAnnotation: NSObject, Identifiable, MKAnnotation {
    let id: Int
    var coordinate: CLLocationCoordinate2D
    let name: String
    let formattedPrice: String
    
    init(property: Property) {
        self.id = property.id
        let proptertyMapMarkers = property.mapMarker.coordinates
        self.coordinate = CLLocationCoordinate2D(latitude: proptertyMapMarkers.latitude, longitude: proptertyMapMarkers.longitude)
        self.name = property.mapMarker.label
        self.formattedPrice = property.price.lead.formatted
    }
}
