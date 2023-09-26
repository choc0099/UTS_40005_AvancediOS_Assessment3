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
}
