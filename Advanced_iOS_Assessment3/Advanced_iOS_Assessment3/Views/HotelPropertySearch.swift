//
//  HotelPropertySearch.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 26/9/2023.
//

import SwiftUI

//this is a struct that will be used to search for rooms to book with multiple criteria.
struct HotelPropertySearch: View {
    @StateObject var roomSearchVM = HotelPropertySearchViewModel()
    @State var region: NeighborhoodSearchResult?
    @State var numbersOfRooms: Int = 0
    @State var numbersOfAdults: Int = 0
    @State var numbersOfChildren: Int = 0
    var body: some View {
        Form {
            Section("Rooms") {
                //allows the user to select numbers of rooms
                Stepper("Numbers of Rooms", value: $numbersOfRooms)
            }
            
            Section("Adults") {//allows the user to select numbers of rooms
                Stepper("Numbers of Rooms", value: $numbersOfRooms)

                Stepper("Numbers of Adults \(numbersOfAdults)", value: $numbersOfAdults)
            }
            
                        
            Section("Check in and Check out Date Ranges") {
                DatePicker("Check In Date", selection:  $roomSearchVM.checkInDate, displayedComponents: [.date])
                DatePicker("Check Out Date", selection: $roomSearchVM.checkOutDate, displayedComponents: [.date])
            }
            
           
        }
    }
}

#Preview {
    //let emptyRegionResult: NeighborhoodSearchResult = NeighborhoodSearchResult()
    HotelPropertySearch()
}
