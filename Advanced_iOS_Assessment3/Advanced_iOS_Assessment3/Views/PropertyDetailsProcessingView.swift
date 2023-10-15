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
    //these are optional variables which will be used to save property search history.
    @State var price: Double?
    @State var totalAdults: Int?
    @State var totalChildren: Int?
    @State var numbersOfNights: Int?
    @State var numbersOfRooms: Int?
    @State var fromPrevious: Bool
    
    var body: some View {
        Group {
            if propertyDetailsVM.status == .loading {
                ProgressView()
            }
            else if propertyDetailsVM.status == .active {
                PropertyDetailView( propertyDetailsVM: propertyDetailsVM, price: price, totalAdults: totalAdults, totalChildren: totalChildren, numbersOfNights: numbersOfNights,  numbersOfRooms: numbersOfRooms)
            }
            else {
              //displays error messages to the user
                ErrorView(errorStatus: propertyDetailsVM.status)
            }
        }.onAppear(perform: {
            //this will prevent the app from fetching data when you press back after viewing a map.
            if fromPrevious {
                Task {
                    await propertyDetailsVM.fetchPropertyDetails(propertyId: propertyId, metaData: hotelMain.metaData)
                    //changes it back to false
                    fromPrevious = false
                }
            }
           
        })
    }
}
/*
#Preview {
    PropertyDetailsProcessingView()
}*/
