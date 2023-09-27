//
//  RoomFieldView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 27/9/2023.
//

import SwiftUI

struct RoomFieldView: View {
    @ObservedObject var roomSearchVM: HotelPropertySearchViewModel
    @State var currentRoom: Room
    var body: some View {
        Group {
            //VStack {
                Stepper("Numbers of adults \(currentRoom.adults) ", value: $currentRoom.adults)
                Stepper("Numbers of Children \(currentRoom.children.count)") {
                roomSearchVM.incrementChildren(currentRoom: &currentRoom)
                } onDecrement: {
                    roomSearchVM.decrmentChildren(currentRoom: &currentRoom)
                }
                    
                    
            Section {
                ForEach(currentRoom.children)
                {
                    child in
                    ChildrenFieldView(roomSearchVM: roomSearchVM, currentChild: child)
                }
            } header: {
                Text("Children")
            }
                
                
            //}
            
        }
    }
}

struct RoomFieldView_Previews: PreviewProvider {
    static var previews: some View {
        let room: Room = Room(index: 0, adults: 1, children: [Children(index: 0, age: 1)])
        RoomFieldView(roomSearchVM: HotelPropertySearchViewModel(), currentRoom: room)
    }
}
