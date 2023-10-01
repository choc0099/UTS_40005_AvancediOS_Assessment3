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
                Section("Numbers of Results") {
                    VStack {
                        Text("\(Int(roomSearchVM.numbersOfResults))")
                        Slider(
                            value: $roomSearchVM.numbersOfResults,
                            in: 5...500
                        )
                    }
                }
                
                Section("Price Range") {
                    Stepper("Minimum Price: $\(roomSearchVM.minPrice)") {
                        roomSearchVM.minPrice += 50
                    } //when the user presses the plus an minus button the price will increase and decrease by $50 respectively
                    onDecrement: {
                        //this will prevent negative numbers.
                        if(roomSearchVM.minPrice > 0) {
                            roomSearchVM.minPrice -= 50
                        }
                    }

                    Stepper("Maximum Price: $\(roomSearchVM.maxPrice)") {
                        roomSearchVM.maxPrice += 50
                    } onDecrement: {
                        //this will prevent negative numbers.
                        if(roomSearchVM.maxPrice > 0) {
                            roomSearchVM.maxPrice -= 50
                        }
                        
                    }

                }
                
            }
        }
    }
}

#Preview {
    PropertySearchPreferencesView(roomSearchVM: HotelPropertySearchViewModel())
}
