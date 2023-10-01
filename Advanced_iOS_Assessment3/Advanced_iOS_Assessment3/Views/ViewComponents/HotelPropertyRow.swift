//
//  HotelPropertyRow.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 28/9/2023.
//

import SwiftUI

struct HotelPropertyRow: View {
    @State var hotelProperty: Property
    var body: some View {
        HStack( spacing: 20) {
            HotelImageView(propertyImage: hotelProperty.propertyImage, imageSize: 30, mapMode: false)
            Spacer()
            VStack(alignment: .leading, spacing: 10) {
                Text(hotelProperty.name).font(.headline).multilineTextAlignment(.leading)
                
                
                    HStack( spacing: 10) {
                        //displays if rooms are available
                        if let roomAvaliable = hotelProperty.availability.minRoomsLeft {
                            Text("\(roomAvaliable) rooms left.")
                        }
                        else {
                            Text("Ne rooms left.")
                        }
                        Spacer()
                        if let haveDiscount = hotelProperty.price.strikeOut {
                            Text(haveDiscount.formatted).strikethrough(pattern: .solid)
                        }
                        Text(hotelProperty.price.lead.formatted).fontWeight(.bold)
                    }.frame(maxWidth: .infinity, alignment: .trailing)
               
            }.frame(maxWidth: .infinity)
        }.frame(maxWidth: .infinity)
    }
}

#Preview {
    HotelPropertyRow(hotelProperty: Property(name: "The Cigarettes Hotel", formattedPrice: "AUD$1000", formattedDiscount: "AUD$600", isAvaliable: true, roomsAvaliable: 9, propertyImage: nil))
}
