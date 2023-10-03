//
//  HotelList.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 26/9/2023.
//

import SwiftUI

//this view handles the proccessing while it is in the process of displaying the search results.
//this includes loading indicators and error messages.
struct PropertyResultsProcessingView: View {
    @ObservedObject var roomSearchVM: HotelPropertySearchViewModel
    @State var regionId: String
    @State var regionCoordinates: Coordinates
    
    var body: some View {
        Group {
            if roomSearchVM.propertyResultStatus == .active {
                PropertyResultsView(roomSearchVM: roomSearchVM, regionId: regionId, regionCoordinates: regionCoordinates)
            }
            else if roomSearchVM.propertyResultStatus == .loading {
                ProgressView()
            }
            else {
                //displays an error message to the user.
                ErrorView(errorStatus: roomSearchVM.propertyResultStatus)
            }
        }
    }
}
/*
#Preview {
    PropertyResultsProcessingView(roomSearchVM: HotelPropertySearchViewModel(), regionId: "", regionCoordinates: Coordinates(lat: -100, long: -100))
}*/
