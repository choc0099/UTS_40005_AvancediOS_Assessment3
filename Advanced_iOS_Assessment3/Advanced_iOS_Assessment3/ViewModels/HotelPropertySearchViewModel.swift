//
//  HotelPropertySearchViewModel.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 27/9/2023.
//

enum QueryError: Error {
    case roomNotFound
}

import Foundation
//this is an obserable class to handle hotel rooms search queries.
class HotelPropertySearchViewModel: ObservableObject {
    @Published var rooms: [Room] = []
    @Published var childrens: [Children] = []
    @Published var checkInDate: Date = Date.now
    @Published var checkOutDate: Date = Date.now
    //determines the numbers of rooms, children and adults
    @Published var numbersOfRooms: Int = 0
    @Published var numbersOfAdults: Int = 0
    @Published var numbersOfChildren: Int = 0
    
    func incrementRooms() {
        self.numbersOfRooms += 1
        rooms.append(Room(index: numbersOfRooms, adults: 0, children: []))
    }
    
    func decrementRooms() {
        //retricts the range so it will not display negative number.
        if(numbersOfRooms > 0)
        {
            rooms.removeLast()
            self.numbersOfRooms -= 1
        }
    }
    
    //increments the number of children inside the room
    func incrementChildren(currentRoom: inout Room) {
        currentRoom.children.append(Children(index: 0, age: 0))
    }
    func decrmentChildren(currentRoom: inout Room)
    {
        if !currentRoom.children.isEmpty {
            //removes a child when decreasing it.
            currentRoom.children.removeLast()
        }
      
    }
    
    //this will get that specific room based on the id
    func findRoomById(roomId: UUID) throws ->  Room {
        if let haveRoom = self.rooms.first(where: {$0.id == roomId})
        {
            return haveRoom
        }
        else {
            throw QueryError.roomNotFound
        }
    }
}
