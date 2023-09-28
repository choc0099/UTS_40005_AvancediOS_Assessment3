//
//  PropertyResultsView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 27/9/2023.
//

import SwiftUI

struct PropertyResultsView: View {
    @ObservedObject var roomSearchVM: HotelPropertySearchViewModel
    var body: some View {
        List{
            ForEach(roomSearchVM.propertyResoults) {
                property in
                Text("\(property.name) ")
                if let havePrice = property.price?.lead {
                    Text("\(havePrice.formatted)")
                }
            }
        }
    }
}

struct PropertyResultsView_Previews: PreviewProvider {
    static var previews: some View {
        
        PropertyResultsView(roomSearchVM: HotelPropertySearchViewModel())
    }
}

