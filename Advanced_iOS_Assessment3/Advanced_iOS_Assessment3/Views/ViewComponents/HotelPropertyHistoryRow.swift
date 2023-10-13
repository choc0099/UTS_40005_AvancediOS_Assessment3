//
//  HotelPropertyHistoryRow.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 13/10/2023.
//

import SwiftUI

struct HotelPropertyHistoryRow: View {
    @State var propertyHistory: PropertyHistory
    var body: some View {
        HStack(spacing: 20) {
            HotelImageView(propertyImage: PropertyImage(typename: "", alt: propertyHistory.imageDescription, accessibilityText: propertyHistory.imageDescription, image: HotelImage(typeName: "", description: propertyHistory.imageDescription, url: propertyHistory.imageUrl ?? ""), subjectId: nil, imageId: nil), imageSize: 35, mapMode: false)
            VStack(alignment: .leading, spacing: 10) {
                Text(propertyHistory.hotelName).font(.headline)
                Text(propertyHistory.hotelAddress).font(.subheadline)
                HStack(spacing: 20) {
                    //numbers of nights
                    AmmenitiesRow(total: propertyHistory.numbersOfNights, systemImageStr: "moon.fill", accessibilityLabel: "nights")
                    //Numbers of Rooms
                    AmmenitiesRow(total: propertyHistory.numbersOfRooms, systemImageStr: "bed.double.fill", accessibilityLabel: "Rooms")
                    //numbers of adults
                    AmmenitiesRow(total: propertyHistory.totalAdults, systemImageStr: "figure", accessibilityLabel: "adults")
                    //numbers of children
                    AmmenitiesRow(total: propertyHistory.totalChildren, systemImageStr: "figure.child", accessibilityLabel: "children")
                    
                }
                Text("Total Cost: $\(propertyHistory.price.formatted())")
            }
            
        }
    }
}

#Preview {
    HotelPropertyHistoryRow(propertyHistory: PropertyHistory(hotelId: "", hotelName: "The Cigarettes Hotel", hotelAddress: "98 Cigarette Street", imageUrl: "https://p.turbosquid.com/ts-thumb/4s/a5xhW9/BGrVhp7c/_01/jpg/1335447577/1920x1080/turn_fit_q99/ed3fbe40eb35885eed3a3ccc9af2f9ae63ef4a9b/_01-1.jpg", numbersOfNights: 5, numbersOfRooms: 3, totalAdults: 2, totalChildren: 2, price: 1000.50))
}
