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
                //the image will be in a circle shape if it is viewed in a map view.
                //if it is not, it will be as a normal rectangle shape.
                if mapMode {
                    image.resizable().aspectRatio(contentMode: .fill).frame(width: imageSize, height: imageSize).clipShape(.circle).overlay(Circle()
                        .stroke(Color.gray, lineWidth: 2)
                    )
                } else {
                    image.resizable().aspectRatio(contentMode: .fill).frame(width: imageSize, height: imageSize)
                        //this will display alt text on an image for vision impaired users.
                        .accessibilityLabel(
                        Text(propertyImage?.alt ?? "image")
                    )
                }
            } placeholder: {
                placeHolderImage()
            }
        } else {
           placeHolderImage()
        }
    }
    
    //a helper function that displays a placeholder image whether it is in map mode or not as it will be dispayed in a circle form when viewing it on a map.
    @ViewBuilder func placeHolderImage() -> some View {
        if mapMode {
            Image(systemName: "building.fill").resizable().aspectRatio(contentMode: .fit).frame(width: imageSize, height: imageSize).clipShape(.circle).overlay(Circle()
                .stroke(Color.gray, lineWidth: 2)
            )
        }
        else {
            Image(systemName: "building.fill").resizable().aspectRatio(contentMode: .fit).frame(width: imageSize, height: imageSize)
        }
        
    }
}

#Preview {
    HotelImageView(propertyImage: PropertyImage(typename: "Cigarettes", alt: "Smoke Test", image: HotelImage(typeName: "smoke", description: "I like smokes", url: "https://images.trvl-media.com/lodging/41000000/40470000/40460600/40460567/d4729cbb.jpg?impolicy=resizecrop&rw=455&ra=fit"), subjectId: 1000), imageSize: 150, mapMode: false)
}
