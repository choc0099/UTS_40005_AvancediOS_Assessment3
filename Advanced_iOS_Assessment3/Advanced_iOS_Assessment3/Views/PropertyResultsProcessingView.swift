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
    @State var region: NeighborhoodSearchResult
    
    var body: some View {
        Group {
            if roomSearchVM.propertyResultStatus == .active {
                PropertyResultsView(roomSearchVM: roomSearchVM, region: region)
            }
            else if roomSearchVM.propertyResultStatus == .loading {
                ProgressView()
            }
            else if roomSearchVM.propertyResultStatus == .unkown {
                VStack {
                    Text("Something went wrong!")
                }
            }
        }
    }
}

#Preview {
    PropertyResultsProcessingView(roomSearchVM: HotelPropertySearchViewModel(), region: NeighborhoodSearchResult(gaiaId: ""))
}
