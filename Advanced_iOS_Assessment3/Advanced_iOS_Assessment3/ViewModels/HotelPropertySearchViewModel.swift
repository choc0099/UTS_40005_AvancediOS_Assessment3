//
//  HotelPropertySearchViewModel.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 27/9/2023.
//

enum QueryError: Error {
    case roomNotFound
    case noChildrenFound
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
        self.rooms.append(Room(index: numbersOfRooms, adults: 0, children: []))
    }
    
    func decrementRooms() {
        //retricts the range so it will not display negative number.
        if(numbersOfRooms > 0)
        {
            self.rooms.removeLast()
            self.numbersOfRooms -= 1
        }
    }
    
    //increments the number of children inside the room
    func incrementChildren(currentRoomId: UUID) {
        //gets the actual refernce of the room to add children.
        if let index = self.rooms.firstIndex(where: {$0.id == currentRoomId}) {
            self.rooms[index].children.append(Children(index: 0, age: 0))
        }
        
    }
    
    func decrmentChildren(currentRoomId: UUID) {
        if let index = self.rooms.firstIndex(where: {$0.id == currentRoomId}) {
            if self.rooms[index].children.isEmpty {
                
                //removes a child when decreasing it.
                self.rooms[index].children.removeLast()
            }
        }
    }
    //this updates the children age on the VM side
    func setChildrenAge(age: Int, roomId: UUID, childId: UUID)
    {
        //gets the allocated room from the array
        if let roomIndex = self.rooms.firstIndex(where: {$0.id == roomId}) {
            //gets the allocated child object from the array
            if let childIndex = self.rooms[roomIndex].children.firstIndex(where: {$0.id == childId}) {
                self.rooms[roomIndex].children[childIndex].age = age
                print("Age update from VM side test \(self.rooms[roomIndex].children[childIndex].age)")
            }
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
    
    func findChildrenById(roomId: UUID, childrenId: UUID) throws -> Children {
        if let roomIndex = self.rooms.firstIndex(where: {$0.id == roomId}) {
            if let index = self.rooms[roomIndex].children.firstIndex(where: {$0.id == childrenId})
            {
                return self.rooms[roomIndex].children[index]
            }
            throw QueryError.noChildrenFound
        }
        
        else {
            throw QueryError.roomNotFound
        }
    }
}
