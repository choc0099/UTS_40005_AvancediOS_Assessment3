//
//  PropertyHistoryView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 13/10/2023.
//

import SwiftUI

struct PropertyHistoryView: View {
    @EnvironmentObject var propertyHistoryVM: PropertyHistoryViewModel
    @EnvironmentObject var hotelMain: HotelBrowserMainViewModel
    var body: some View {
        NavigationStack {
            Group {
                if(propertyHistoryVM.status == .active) {
                    List {
                        ForEach(propertyHistoryVM.sortedHistory) {
                            historyItem in
                            NavigationLink(destination: PropertyDetailsProcessingView(propertyId: historyItem.hotelId)) {
                                HotelPropertyHistoryRow(propertyHistory: historyItem)
                            }.swipeActions {
                                Button("Delete", role: .destructive) {
                                    if let user = hotelMain.loggedInUser {
                                        //removes the item from the database
                                        propertyHistoryVM.removeHistoryItem(user.uid, uuId: historyItem.id)
                                    }
                                  
                                }
                            }
                        }
                    }
                } else {
                    //displays a error message to the user.
                    ErrorView(errorStatus: propertyHistoryVM.status)
                }
               
            }
        }
    }
}

#Preview {
    PropertyHistoryView()
}
