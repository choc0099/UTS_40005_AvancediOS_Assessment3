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
        HStack {
            HotelImageView(propertyImage: PropertyImage(typename: "", alt: favourite.imageDescription, accessibilityText: nil, image: HotelImage(typeName: "", description: nil, url: favourite.imageUrl), subjectId: nil, imageId: nil), imageSize: 50, mapMode: false)
            VStack(spacing: 10, content: {
                Text(favourite.hotelName)
                Text(favourite.hotelAddress)
            })
        }
    }
}

#Preview {
    HotelFavouritesRow(favourite: HotelFavourite(hotelId: "8882", hotelName: "The Cigarette Hotel", hotelAddress: "8822 Cigarette Street URLVale", imageUrl: "", imageDescription: nil))
}
