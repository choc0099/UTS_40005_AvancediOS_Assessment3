//
//  PropertyDetailView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 1/10/2023.
//

import SwiftUI

struct PropertyDetailView: View {
    @EnvironmentObject var hotelMain: HotelBrowserMainViewModel
    @StateObject var propertyDetailsVM: HotelPropertyDetailViewModel = HotelPropertyDetailViewModel()
    @State var propertyId: String
    
    var body: some View {
        Group {
            Text(propertyDetailsVM.propertyDescription)
        }.onAppear(perform: {
            if let haveMetaData = hotelMain.metaData {
                Task {
                    //loads the property details from the APIa
                    await propertyDetailsVM.fetchPropertyDetails(propertyId:propertyId, metaData: haveMetaData)
                }
            }
            
        })
    }
}

#Preview {
    PropertyDetailView(propertyId: "")
}
