//
//  ErrorView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 3/10/2023.
//

import SwiftUI

//this is a view that are used to display error messages to the user.
struct ErrorView: View {
    @State var errorStatus: HotelStatus
    @State var errorTitle: String = ""
    @State var errorText: String = ""
    @State var systemImageStr: String = ""
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: systemImageStr).resizable().frame(width: 100, height: 100).foregroundColor(.gray)
            Text("\(errorTitle)").font(.title2)
            Text("\(errorText)").font(.headline)
        }.frame(maxHeight: .infinity).onAppear(perform: {
            updateText()
        }) //this will update error messages if the state was to change.
        .onChange(of: errorStatus) { error in
            updateText()
        }
    }
    
    func updateText() {
        //adds text depnding on scenarios
        switch(errorStatus) {
        case .welcome:
            systemImageStr = "building.columns.circle"
            errorTitle = "Welcome to Hotel Browser"
            errorText = "Search here to get started"
        case .noResults:
            systemImageStr = "exclamationmark.magnifyingglass"
            errorTitle = "No Results Found"
        case .offline:
            systemImageStr = "network.slash"
            errorTitle = "You are currently offline."
        case .requestTimeOut:
            systemImageStr = "network.slash"
            errorTitle = "Request timed out."
        case .unkown:
            systemImageStr = "exclamationmark.triangle"
            errorTitle = "Something went wrong!"
            errorText = "We couldn't process your request."
        case .noFavourites:
            systemImageStr = "heart.slash.circle"
            errorTitle = "No favourites"
            errorText = "There are no hotel favourites."
        case .noHistory:
            systemImageStr = "clock.badge.xmark"
            errorTitle = "No Recent Property searches."
            errorText = "There are no property history."
        default:
            errorText = ""
        }
    }
}

#Preview {
    ErrorView(errorStatus: .noResults)
}
