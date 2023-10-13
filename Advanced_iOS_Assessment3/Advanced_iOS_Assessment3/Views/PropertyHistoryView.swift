//
//  PropertyHistoryView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 13/10/2023.
//

import SwiftUI

struct PropertyHistoryView: View {
    @EnvironmentObject var propertyHistoryVM: PropertyHistoryViewModel
    var body: some View {
        NavigationStack {
            List {
                ForEach(propertyHistoryVM.propertyHistory) {
                    historyItem in
                    NavigationLink(destination: PropertyDetailsProcessingView(propertyId: historyItem.hotelId)) {
                        HotelPropertyHistoryRow(propertyHistory: historyItem)
                    }
                    
                }
            }
        }
    }
}

#Preview {
    PropertyHistoryView()
}
