//
//  PropertyDetailsProcessingView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 3/10/2023.
//

import SwiftUI

struct PropertyDetailsProcessingView: View {
    @StateObject var propertyDetailsVM: HotelPropertyDetailViewModel = HotelPropertyDetailViewModel()
    @EnvironmentObject var hotelMain: HotelBrowserMainViewModel
    @State var propertyId: String
    
    var body: some View {
        Group {
            if propertyDetailsVM.status == .loading {
                ProgressView()
            }
            else if propertyDetailsVM.status == .active {
                PropertyDetailView(propertyDetailsVM: propertyDetailsVM)
            }
            else {
              //displays error messages to the user
                ErrorView(errorStatus: propertyDetailsVM.status)
            }
        }.onAppear(perform: {
            Task {
                if let metaData = hotelMain.metaData {
                    await propertyDetailsVM.fetchPropertyDetails(propertyId: propertyId, metaData: metaData)
                    propertyDetailsVM.updateFavouriteStatus()
                }
                else {
                    propertyDetailsVM.status = .unkown
                }
            }
        })
    }
}
/*
#Preview {
    PropertyDetailsProcessingView()
}*/
