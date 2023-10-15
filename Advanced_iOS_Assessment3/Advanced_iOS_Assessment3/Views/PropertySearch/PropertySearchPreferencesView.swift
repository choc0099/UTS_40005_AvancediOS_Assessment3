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
                //allows to chose maximum numbers of hotel results upon search.
                Section("Numbers of Results") {
                    VStack {
                        Text("\(Int(roomSearchVM.numbersOfResults))")
                        Slider(
                            value: $roomSearchVM.numbersOfResults,
                            in: 5...500
                        )
                    }
                }
                //minimum and maximum price ranges for budgeting.
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
    
    //helper function to save to user defaults.
    func saveToUserDefaults() {
        roomSearchVM.saveToUserDefaults(regionId: regionId, metaData: hotelMain.metaData)
    }
}

#Preview {
    PropertySearchPreferencesView(roomSearchVM: HotelPropertySearchViewModel(), regionId: "")
}
