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
    let id: UUID = UUID()
    let hotelId: String
    let property: Property
    var coordinate: CLLocationCoordinate2D
    let name: String
    let formattedPrice: String
    
    init(property: Property) {
        self.hotelId = property.hotelId
        let proptertyMapMarkers = property.mapMarker.coordinates
        self.coordinate = CLLocationCoordinate2D(latitude: proptertyMapMarkers.latitude, longitude: proptertyMapMarkers.longitude)
        self.name = property.name
        self.formattedPrice = property.price.lead.formatted
        self.property = property
    }
}
