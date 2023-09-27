//
//  ChildrenFieldView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 27/9/2023.
//

import SwiftUI

struct ChildrenFieldView: View {
    @ObservedObject var roomSearchVM: HotelPropertySearchViewModel
    @State var currentChild: Children
    @State var ageInput: Int = 0;
    
    var body: some View {
        Stepper("Age: \(ageInput)", value: $ageInput)
    }
}

#Preview {
    ChildrenFieldView(roomSearchVM: HotelPropertySearchViewModel(), currentChild: Children(index: 0, age: 0))
}
