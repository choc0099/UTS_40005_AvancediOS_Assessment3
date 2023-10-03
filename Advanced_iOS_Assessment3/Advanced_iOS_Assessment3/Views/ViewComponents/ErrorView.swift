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
    var body: some View {
        VStack(spacing: 10) {
            Text("\(errorTitle)").font(.headline)
            Text("\(errorText)").font(.subheadline)
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
            errorText = "Welcome to Hotel Browser"
        case .noResults:
            errorText = "No Results Found"
        case .offline:
            errorText = "You are currently offline."
        case .requestTimeOut:
            errorText = "Request timed out."
        case .unkown:
            errorText = "Something went wrong!"
        default:
            errorText = ""
        }
    }
}

#Preview {
    ErrorView(errorStatus: .welcome)
}
