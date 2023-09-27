//
//  HotelPropertySearch.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 26/9/2023.
//

import SwiftUI

//this is a struct that will be used to search for rooms to book with multiple criteria.
struct HotelPropertySearchView: View {
    @StateObject var roomSearchVM = HotelPropertySearchViewModel()
    @State var region: NeighborhoodSearchResult?
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Check in and Check out Date Ranges") {
                    DatePicker("Check In Date", selection:  $roomSearchVM.checkInDate, displayedComponents: [.date])
                    DatePicker("Check Out Date", selection: $roomSearchVM.checkOutDate, displayedComponents: [.date])
                }
                
                Section("Rooms") {
                    //allows the user to select numbers of rooms
                    Stepper("Numbers of Rooms: \(roomSearchVM.numbersOfRooms)") {
                        roomSearchVM.incrementRooms()
                    } onDecrement: {
                        roomSearchVM.decrementRooms()
                    }
                }
                
                ForEach(roomSearchVM.rooms) {
                    //allows the user to select numbers of rooms
                    room in
                    NavigationLink(value: room) {
                        Text("Room \(room.index)")
                    }
                }
            }.navigationDestination(for: Room.self) {
                room in
                RoomFieldView(roomSearchVM: roomSearchVM, currentRoomId: room.id)
            }
        
        }.navigationTitle("Search Property")
    }
    
    //a function to initialse rooms array.
}

#Preview {
    //let emptyRegionResult: NeighborhoodSearchResult = NeighborhoodSearchResult()
    HotelPropertySearchView()
}
