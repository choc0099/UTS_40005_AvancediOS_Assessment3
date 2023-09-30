//
//  HotelImageView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 30/9/2023.
//

import SwiftUI

struct HotelImageView: View {
    @State var propertyImage: PropertyImage?
    @State var imageSize: CGFloat
    @State var mapMode: Bool
    var body: some View {
        //this is an async image view
        
        //checks if there is an image URL in the hotel propertyImage, if not, it will display a placeholder image.
        if let haveImageURL = propertyImage?.image?.url  {
            AsyncImage(url: URL(string: haveImageURL)) { image in
                if mapMode {
                    image.resizable().aspectRatio(contentMode: .fill).frame(width: imageSize, height: imageSize).clipShape(.circle).overlay(Circle()
                        .stroke(Color.gray, lineWidth: 2)
                    )
                }  else {
                    image.resizable().aspectRatio(contentMode: .fill).frame(width: imageSize, height: imageSize)
                }
                
            } placeholder: {
                Image(systemName: "building.fill").aspectRatio(contentMode: .fill).frame(width: imageSize, height: imageSize)
            }
        } else {
            Image(systemName: "building.fill").resizable().aspectRatio(contentMode: .fit).frame(width: imageSize, height: imageSize)
        }
    }
}

#Preview {
    HotelImageView(propertyImage: PropertyImage(typename: "Cigarettes", alt: "Smoke Test", image: HotelImage(typeName: "smoke", description: "I like smokes", url: "https://images.trvl-media.com/lodging/41000000/40470000/40460600/40460567/d4729cbb.jpg?impolicy=resizecrop&rw=455&ra=fit"), subjectId: 1000), imageSize: 150, mapMode: true)
}
