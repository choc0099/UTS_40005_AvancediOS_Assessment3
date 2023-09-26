//
//  HotelPropertySearchViewModel.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 27/9/2023.
//

import Foundation
//this is an obserable class to handle hotel rooms search queries.
class HotelPropertySearchViewModel: ObservableObject {
    @Published var rooms: [Rooms] = []
    @Published var childrens: [Children] = []
    @Published var checkInDate: Date = Date.now
    @Published var checkOutDate: Date = Date.now
    //determines the numbers of rooms, children and adults
    @Published var numbersOfRooms: Int = 0
    @Published var numbersOfAdults: Int = 0
    @Published var numbersOfChildren: Int = 0
    
    func incrementRooms() {
        
        self.numbersOfRooms += 1
        rooms.append(Rooms(index: numbersOfRooms, adults: 0, children: []))
        
    }
    
    func decrementRooms() {
        //retricts the range so it will not display negative number.
        if(numbersOfRooms > 0)
        {
            
            rooms.removeLast()
            self.numbersOfRooms -= 1
        }
    }
}
