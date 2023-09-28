//
//  HotelPropertyRow.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 28/9/2023.
//

import SwiftUI

struct HotelPropertyRow: View {
    @State var name: String
    @State var formattedPrice: String
    @State var formattedDiscount: String?
    @State var hotelImage: HotelImage?
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: "building.fill").resizable().frame(width: 50, height: 50)
            VStack(spacing: 10) {
                Text(name)
                Text(formattedPrice).bold()
                if let haveDiscount = formattedDiscount {
                    Text(haveDiscount)
                }
            }
        }
    }
}

#Preview {
    HotelPropertyRow(name: "Cigarettes Hotel", formattedPrice: "AUD$600")
}
