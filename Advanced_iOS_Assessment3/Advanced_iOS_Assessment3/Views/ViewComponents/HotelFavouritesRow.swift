//
//  HotelFavouritesRow.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 5/10/2023.
//

import SwiftUI

struct HotelFavouritesRow: View {
    @State var favourite: HotelFavourite
    var body: some View {
        HStack(spacing: 20) {
            HotelImageView(propertyImage: PropertyImage(typename: "", alt: favourite.imageDescription, accessibilityText: nil, image: HotelImage(typeName: "", description: nil, url: favourite.imageUrl), subjectId: nil, imageId: nil), imageSize: 35, mapMode: false)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(favourite.hotelName).font(.headline)
                Text(favourite.hotelAddress).font(.subheadline)
            }
        }
    }
}

#Preview {
    HotelFavouritesRow(favourite: HotelFavourite(hotelId: "8882", hotelName: "The Cigarette Hotel", hotelAddress: "8822 Cigarette Street URLVale", imageUrl: "", imageDescription: nil))
}
