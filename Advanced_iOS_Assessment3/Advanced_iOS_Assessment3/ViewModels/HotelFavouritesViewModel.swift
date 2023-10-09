//
//  HotelFavouritesViewModel.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 5/10/2023.
//

import Foundation
import PromiseKit
import FirebaseCore
import FirebaseDatabase

class HotelFavouritesViewModel: ObservableObject {
    @Published var favourites: [HotelFavourite] = []
    @Published var status: HotelStatus = .loading
    
    init() {
        fetchFavourites()
        //readFavourites()
    }
    
    //loads the favourites from the DB
    func fetchFavourites() {
        //var fetchedFavourites: [HotelFavourite] = []
        
        FirebaseManager.readFavourites()
            .done { favourites in
                self.favourites = favourites
                print(self.favourites)
            }
            .catch { error in
                self.status = .unkown
            }
    }
    
    func removeFromFavourites(propertyId: String) throws {
        FirebaseManager.removeFavouriteFromDB(propertyId: propertyId)
            .done {
                print("\(propertyId) Removed from favourites")
            }
            .catch { error in
                print("failed to delete")
            }
    }
    
}
