//
//  HotelFavouritesViewModel.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 5/10/2023.
//

import Foundation

class HotelFavouritesViewModel: ObservableObject {
    var favourites = [HotelFavourite]()
    var status: HotelStatus = .loading
    
    init() {
        //self.favourites = fetchFavourites()
    }
    
    //loads the favourites from the DB
    func fetchFavourites() async {
        //var fetchedFavourites: [HotelFavourite] = []
        
            FirebaseManager.readFavourites { [weak self] (favourites, error) in
                DispatchQueue.main.async {
                    guard let self = self else {
                        return
                    }
                    if let error = error {
                        self.status = .noResults
                    }
                    
                    else {
                        if let haveFavourites = favourites {
                            self.favourites = haveFavourites
                       
                            self.status = .active
                            
                        }
                    }
                }
                //self.favourites = fetchedFavourites
                //print(self.status)
            }
        
        
    }
}
