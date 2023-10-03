//
//  PropertySearchPreferencesView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 1/10/2023.
//

import SwiftUI

struct PropertySearchPreferencesView: View {
    @ObservedObject var roomSearchVM: HotelPropertySearchViewModel
    @EnvironmentObject var hotelMain: HotelBrowserMainViewModel
    @State var regionId: String
    
    var body: some View {
        NavigationStack {
            Form{
                Section("Sort Results") {
                    Picker("Sort By", selection: $roomSearchVM.sort) {
                        ForEach(SortPropertyBy.allCases)  {
                            sortMethod in
                            Text(sortMethod.displayName)
                        }
                    }
                    .onChange(of: roomSearchVM.sort) { sortMethod in
                        //saves to user defaults
                        print(sortMethod.rawValue)
                        saveToUserDefaults()
                    }
                }
                
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
                        saveToUserDefaults()
                    } //when the user presses the plus an minus button the price will increase and decrease by $50 respectively
                    onDecrement: {
                        //this will prevent negative numbers.
                        if(roomSearchVM.minPrice > 0) {
                            roomSearchVM.minPrice -= 50
                            saveToUserDefaults()
                        }
                    }

                    Stepper("Maximum Price: $\(roomSearchVM.maxPrice)") {
                        roomSearchVM.maxPrice += 50
                        saveToUserDefaults()
                    } onDecrement: {
                        //this will prevent negative numbers.
                        if(roomSearchVM.maxPrice > 0) {
                            roomSearchVM.maxPrice -= 50
                            saveToUserDefaults()
                        }
                    }
                }
            }
        }
    }
    
    func saveToUserDefaults() {
        if let haveMetaData = hotelMain.metaData {
            roomSearchVM.saveToUserDefaults(regionId: regionId, metaDat: haveMetaData)
        }
    }
}

#Preview {
    PropertySearchPreferencesView(roomSearchVM: HotelPropertySearchViewModel(), regionId: "")
}
