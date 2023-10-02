//
//  HotelPropertyRow.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 28/9/2023.
//

import SwiftUI


struct HotelPropertyRow: View {
    @State var hotelProperty: Property
    //this is a computed property to display the review message such as good or not.
    var reviewsMessage: String {
        if let haveReview = hotelProperty.reviews {
            switch haveReview.score {
            case 0...2.4:
                return "Very Poor"
            case 2.5...4:
                return "Poor"
            case 4.1...5.5:
                return "Average"
            case 5.6...7.0:
                return "Good"
            case 7.1...8.8:
                return "Excelecnt"
            case 8.9...10.0:
                return "Briliant"
            default:
                return ""
            }
        } else {
            return ""
        }
    }
    
    var body: some View {
        HStack( spacing: 20) {
            HotelImageView(propertyImage: hotelProperty.propertyImage, imageSize: 30, mapMode: false)
            Spacer()
            VStack(alignment: .leading, spacing: 10) {
                Text(hotelProperty.name).font(.headline).multilineTextAlignment(.leading)
                HStack(spacing: 10) {
                    if let roomAvaliable = hotelProperty.availability.minRoomsLeft {
                        Text("\(roomAvaliable) rooms left.").font(.subheadline)
                    } else {
                        Text("Ne rooms left.").font(.subheadline)
                    }
                    if let haveReviews = hotelProperty.reviews {
                        Text("\(haveReviews.score.formatted())/10 \(reviewsMessage)").font(.subheadline).padding(3.0).bold().background(.gray).foregroundColor(.primary).border(.primary)
                    }
                }
                HStack(spacing: 10) {
                    //displays if rooms are available=
                    if let haveDiscount = hotelProperty.price.strikeOut {
                        Text(haveDiscount.formatted).font(.subheadline).strikethrough(pattern: .solid)
                    }
                    Text(hotelProperty.price.lead.formatted).font(.subheadline).fontWeight(.bold)
                }.frame(maxWidth: .infinity, alignment: .trailing)
            }.frame(maxWidth: .infinity)
        }.frame(maxWidth: .infinity)
    }   
}

#Preview {
    HotelPropertyRow(hotelProperty: Property(name: "The Cigarettes Hotel and Resort", formattedPrice: "AUD$1000", formattedDiscount: "AUD$600", isAvaliable: true, roomsAvaliable: nil, propertyImage: nil, review: 7.8))
}
