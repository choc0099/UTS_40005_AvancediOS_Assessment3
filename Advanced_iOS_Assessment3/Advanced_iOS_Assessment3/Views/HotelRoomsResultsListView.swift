//
//  HotelRoomsResultsView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 27/9/2023.
//

import SwiftUI

struct HotelRoomsResultsListView: View {
    @ObservedObject var roomSearchVM: HotelPropertySearchViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    HotelRoomsResultsListView(roomSearchVM: HotelPropertySearchViewModel())
}
