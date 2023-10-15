//
//  RoomFieldView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 27/9/2023.
//

import SwiftUI

struct RoomFieldView: View {
    @ObservedObject var roomSearchVM: HotelPropertySearchViewModel
    @State var currentRoomId: UUID //this will be passed based on a room id to reference to the object
    @State var currentRoom: Room = Room(adults: 0, children: [])
    @State var numberOfAdults: Int = 0
    //these are only used to update userDefaults settings for searchListProperty
    @State var regionId: String
    @EnvironmentObject var hotelMain: HotelBrowserMainViewModel
    
    var body: some View {
        Group {
            Form {
                Stepper("Numbers of adults \(numberOfAdults) ", value: $numberOfAdults).onChange(of: numberOfAdults, perform: {
                    adults in
                    //updates the value on the VM side when it is incremented or decremented.
                    roomSearchVM.setAdults(roomId: currentRoomId, numberOfAdults: adults)
                    updateRoomValues()
                    saveToUserDefaults()
                    
                })
                Stepper("Numbers of Children \(currentRoom.children.count)") {
                    roomSearchVM.incrementChildren(currentRoomId: currentRoomId)
                    updateRoomValues()
                    saveToUserDefaults()
                } onDecrement: {
                    roomSearchVM.decrmentChildren(currentRoomId: currentRoomId)
                    updateRoomValues()
                    saveToUserDefaults()
                }
                
                
                Section {
                    ForEach(currentRoom.children) {
                        child in
                        ChildrenFieldView(roomSearchVM: roomSearchVM, currentRoomId: currentRoomId, currentChildId: child.id, regionId: regionId)
                    }
                } header: {
                    Text("Children")
                }
            }.navigationTitle("Room ")
        }.onAppear {
           updateRoomValues()
        }
    }
    
    //refreshes the UI when a value is changed.
    func updateRoomValues() {
        //retrieve room object based on room id so it can be dyanmically be updated without the need of binding.
        currentRoom = try! roomSearchVM.findRoomById(roomId: currentRoomId)
        numberOfAdults = currentRoom.adults
    }
    
    //helper function to save to user defaults.
    func saveToUserDefaults() {
        roomSearchVM.saveToUserDefaults(regionId: regionId, metaData: hotelMain.metaData)
    }
}

struct RoomFieldView_Previews: PreviewProvider {
    static var previews: some View {
        let room: Room = Room(adults: 1, children: [Children(age: 1)])
        RoomFieldView(roomSearchVM: HotelPropertySearchViewModel(), currentRoomId: room.id, regionId: "")
    }
}
