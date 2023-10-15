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
import FirebaseAuth

class HotelFavouritesViewModel: ObservableObject {
    @Published var favourites: [HotelFavourite] = []
    @Published var status: HotelStatus = .loading
    @Published var showAlert: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    
    
    //loads the favourites from the DB
    func fetchFavourites() {
        //var fetchedFavourites: [HotelFavourite] = []
        
        FirebaseRDManager.readFavourites()
            .done { favourites in
                self.favourites = favourites
                print(self.favourites) //this is used for debugging purposes.
                
                //this will display a no favourites message to the user if there are no favourites fouond from the database.
                if self.favourites.isEmpty {
                    self.status = .noFavourites
                } else {
                    self.status = .active
                }
            }
            .catch { error in
                //this will show the user that there are no favourites even though its an error, especailly when they use the app for the first time.
                self.status = .noFavourites
                print(error)
                print(error.localizedDescription)
            }
    }
    //this is a helper function that removes a favoruite from the view
    //instead of using do - catch blocks, promiseKit is used to handle errors.
    func removeFromFavourites(propertyId: String) {
        FirebaseRDManager.removeFavouriteFromDB(propertyId: propertyId)
            .done {
                print("\(propertyId) Removed from favourites")
            }
            .catch { error in
                print(error)
                print(error.localizedDescription)
                //displays an alert to the user
                self.showAlert = true
                self.alertTitle = "An error has occurred. "
                self.alertMessage = "Unable to remove this favourite."
            }
    }
    
}
