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
    @State var currentRoom: Room = Room(index: 0, adults: 0, children: [])
    var body: some View {
        Group {
            Form {
                Stepper("Numbers of adults \(currentRoom.adults) ", value: $currentRoom.adults)
                Stepper("Numbers of Children \(currentRoom.children.count)") {
                    roomSearchVM.incrementChildren(currentRoomId: currentRoomId)
                    updateRoomValues()
                } onDecrement: {
                    roomSearchVM.decrmentChildren(currentRoomId: currentRoomId)
                    updateRoomValues()
                }
                
                
                Section {
                    ForEach(currentRoom.children) {
                        child in
                        ChildrenFieldView(roomSearchVM: roomSearchVM, currentRoomId: currentRoomId, currentChildId: child.id)
                    }
                } header: {
                    Text("Children")
                }
            }.navigationTitle("Room \(currentRoom.index)")
        }.onAppear {
           updateRoomValues()
        }
    }
    
    func updateRoomValues() {
        //retrieve room object based on room id so it can be dyanmically be updated without the need of binding.
        currentRoom = try! roomSearchVM.findRoomById(roomId: currentRoomId)
    }
}

struct RoomFieldView_Previews: PreviewProvider {
    static var previews: some View {
        let room: Room = Room(index: 0, adults: 1, children: [Children(index: 0, age: 1)])
        RoomFieldView(roomSearchVM: HotelPropertySearchViewModel(), currentRoomId: room.id)
    }
}
