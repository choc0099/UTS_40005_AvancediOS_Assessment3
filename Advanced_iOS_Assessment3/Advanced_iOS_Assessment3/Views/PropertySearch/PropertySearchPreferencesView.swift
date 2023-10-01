//
//  PropertySearchPreferencesView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 1/10/2023.
//

import SwiftUI

struct PropertySearchPreferencesView: View {
    @ObservedObject var roomSearchVM: HotelPropertySearchViewModel
    var body: some View {
        NavigationStack {
            Form{
                
            }
        }
    }
}

#Preview {
    PropertySearchPreferencesView(roomSearchVM: HotelPropertySearchViewModel())
}
