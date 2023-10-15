//
//  MapImageView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 3/10/2023.
//

import SwiftUI

//this is an image view to display a static map image from a URL
struct MapImageView: View {
    @State var mapImage: PropertyStaticImage
    var body: some View {
        AsyncImage(url: URL(string: mapImage.url)!) { image in
            image.resizable().aspectRatio(contentMode: .fit)
        } placeholder: {
            //a rectangle shape will be used as a placeholder
            Rectangle().fill(.red).frame(width: 120, height: 60)
        }
    }
}

#Preview {
    MapImageView(mapImage: PropertyStaticImage(description: "", url: "https://maps.googleapis.com/maps/api/staticmap?channel=expedia-HotelInformation&maptype=roadmap&format=jpg&zoom=13&scale=&size=600x120&markers=icon:https://a.travel-assets.com/shopping-pwa/images/his-preview-marker.png%7C-33.933838,151.1657&key=AIzaSyCYjQus5kCufOpSj932jFoR_AJiL9yiwOw&signature=i3Hfv7lRAerqWqe8zLaAmyHmepg="))
}
