//
//  HotelFavouritesViewModel.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 5/10/2023.
//

import Foundation

class HotelFavouritesViewModel: ObservableObject {
    var favourites = [HotelFavourite]()
    var status: HotelStatus = .active
    
    //loads the favourites from the DB
    func fetchFavourites() {
        do {
            print("Fetch favourites called")
            self.favourites = try FirebaseManager.readFavourites()
            print(favourites.count)
        }
        catch {
            status = .noResults
            print("There is no data.")
        }
    }
}
