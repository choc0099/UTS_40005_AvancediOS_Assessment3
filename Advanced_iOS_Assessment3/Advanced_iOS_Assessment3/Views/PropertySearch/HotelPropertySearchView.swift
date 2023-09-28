//
//  HotelPropertySearch.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 26/9/2023.
//

import SwiftUI

//this is a struct that will be used to search for rooms to book with multiple criteria.
struct HotelPropertySearchView: View {
    //this is used to retrieve metadata
    @EnvironmentObject var hotelMain: HotelBrowserMainViewModel
    @StateObject var roomSearchVM = HotelPropertySearchViewModel()
    @State var region: NeighborhoodSearchResult?
    @State var navActive: Bool = false
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
                    NavigationLink(destination: RoomFieldView(roomSearchVM: roomSearchVM, currentRoomId: room.id)) {
                        Text("Room \(room.index)")
                    }
                }
            }.onAppear(perform: {
                if let haveRegion = region?.gaiaId {
                    print(haveRegion) //6047790
                }
            })
            .toolbar {
                Button {
                    if let haveMetaData = hotelMain.metaData {
                        if let haveRegion = region {
                            Task {
                               //loads the response to the VM
                                await roomSearchVM.fetchResults(metaData: haveMetaData, gaiaId: haveRegion.gaiaId!)
                                navActive = true
                            }
                        }
                        else {
                            print("No region")
                        }
                    }
                    else {
                        print("No metaData")
                    }
                } label: {
                    Text("Continue")
                }
            }.navigationDestination(isPresented: $navActive) {
                PropertyResultsView(roomSearchVM: roomSearchVM)
            }
        
        }.navigationTitle("Search Property")
    }
}

#Preview {
    //let emptyRegionResult: NeighborhoodSearchResult = NeighborhoodSearchResult()
    HotelPropertySearchView()
}
