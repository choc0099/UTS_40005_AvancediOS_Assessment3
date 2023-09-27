//
//  RoomFieldView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 27/9/2023.
//

import SwiftUI

struct RoomFieldView: View {
    @ObservedObject var roomSearchVM: HotelPropertySearchViewModel
    var body: some View {
        
            Stepper("Numbers of adults", value: $roomSearchVM.numbersOfAdults)
            Stepper("Numbers of children", value: $roomSearchVM.numbersOfChildren)
        
    }
}

#Preview {
    RoomFieldView(roomSearchVM: HotelPropertySearchViewModel())
}
