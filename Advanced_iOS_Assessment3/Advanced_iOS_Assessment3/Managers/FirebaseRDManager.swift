//
//  FirebaseManager.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 5/10/2023.
//

import Foundation
import FirebaseCore
import FirebaseDatabase
import FirebaseAuth
import FirebaseFirestore
//these are used to handle Firebase async functions that does not have the async modifer.

import PromiseKit
//this is a class to store and retrieve data from the Firebase server.

enum FireBaseRDError: Error {
    case deleteFailed
    case readFailed
    case addFailed
    case noResults
    case invalidId
    case userNotLoggedIn
}

class FirebaseRDManager {
    private static let ref: DatabaseReference = Database.database().reference(fromURL: "https://hotel-browser-default-rtdb.firebaseio.com/")
    
    //tests writing data to database
    static func testWrite() {
        //creates a dictionary
        let hotelFavourite  = [
            "hotelName": "The Cigarettes Hotel",
            "propertyId": "9912358102",
            "imageUrl" : "www.google.com/images"
        ]
        
        self.ref.child("favourites").childByAutoId().setValue(hotelFavourite)
        //self.ref.setValue("Smokes")
    }
    
    static func readFavourites() -> Promise<[HotelFavourite]> {
        return Promise {
            seal in
            //check if the user is authenticated.
            if let currentUser = FirebaseAuthManager.authRef.currentUser {
                //reads the data from the db and encapsulates into an object, then it stores it on an array
                ref.child("users").child(currentUser.uid).child("hotelFavourites").observeSingleEvent(of: .value) { (snapshot) in
                    
                    if let favourites = snapshot.value as? [String: [String: Any]] {
                        var favouritesTemp = [HotelFavourite]()
                        //loops through an dictionary
                        for (key, favourite) in favourites {
                            //print(key)
                            //print(favourite["hotelName"]!)
                            //creates an object
                            let favouriteObj: HotelFavourite = HotelFavourite(hotelId: key, hotelName: favourite["hotelName"]! as! String, hotelAddress: favourite["hotelAddress"]! as! String, imageUrl: favourite["imageUrl"] as? String , imageDescription: favourite["imageDescription"] as? String)
                            //adds it to the array
                            favouritesTemp.append(favouriteObj)
                        }
                        seal.fulfill(favouritesTemp)
                        
                    } else {
                        //print("no data")
                        seal.fulfill([])
                    }
                    //handles the error
                } withCancel: { error in
                    seal.reject(error)
                }
            } else {
                seal.reject(FireBaseRDError.userNotLoggedIn)
            }
        }
    }
    
    //this will get the specific favourite which will be used to check if a favourite already exists to determine if it can be removed.
    static func getSpecificFavourite(propertyId: String) -> Promise<HotelFavourite?> {
        return Promise {
            seal in
            //checks if there is an authenticated user
            if let user = FirebaseAuthManager.authRef.currentUser {
                ref.child("users").child(user.uid).child("hotelFavourites").child(propertyId).observeSingleEvent(of: .value) { (snapshot) in
                    print("Test")
                    print(snapshot)
                    //print(snapshot.value)
                    print(snapshot.key)
                    if let value = snapshot.value as? [String: Any] {
                        let hotelFavourite: HotelFavourite = HotelFavourite(hotelId: snapshot.key, hotelName: value["hotelName"] as! String, hotelAddress: value["hotelAddress"] as! String, imageUrl: value["imageUrl"] as? String)
                        print("This is the specific favourite.")
                        print(hotelFavourite)
                        seal.fulfill(hotelFavourite)
                    }
                    else {
                        seal.fulfill(nil)
                    }
                } withCancel: { error in
                    seal.reject(error)
                }
            }
            
        }
    }
    
    //this function will print the results into the console.
    static func testRead() {
        ref.child("favourites").observeSingleEvent(of: .value, with: { (snapshot) in
                if let value = snapshot.value as? [String: [String: String]] {
                    for (key, favorite) in value {
                        print("Key: \(key)")
                        print("Hotel Name: \(favorite["hotelName"] ?? "")")
                        print("Image URL: \(favorite["imageUrl"] ?? "")")
                        print("Property ID: \(favorite["propertyId"] ?? "")")
                        print("---")
                    }
                } else {
                    print("No data found")
                }
            }) { (error) in
                print(error.localizedDescription)
            }
    }
    
    static func saveFavouriteToDB(favourite: HotelFavourite) -> Promise<Void> {
        return Promise {
            seal in
            if let user = FirebaseAuthManager.authRef.currentUser {
                ref.child("users").child(user.uid).child("hotelFavourites").child(favourite.hotelId).setValue(favourite.dictionary) {
                    (error, _) in
                    if let error = error {
                        seal.reject(error)
                    }
                    seal.fulfill(())
                }
            }
            
        }
        
    }
    
    static func removeFavouriteFromDB(propertyId: String) -> Promise<Void> {
        //using promiseKit to handle asynchronous tasks from Firebase.
        return Promise {
            seal in
            if let user = FirebaseAuthManager.authRef.currentUser {
                ref.child("users").child(user.uid).child(propertyId).removeValue {
                    (error, _) in
                    if let error = error {
                        seal.reject(error)
                    }
                    seal.fulfill(())
                }
            }
        
            
        }
    }
    
    static func removePropertyHistoryItemFromDB(id: UUID) -> Promise<Void> {
        return Promise {
            seal in
            if let user = FirebaseAuthManager.authRef.currentUser {
                ref.child("users").child(user.uid).child("history").child(id.uuidString).removeValue() {
                    (error, _) in
                    //if there is an error deleting
                    if let error = error {
                        seal.reject(error)
                    }
                    seal.fulfill(())
                    
                }
            }
          
          
        }
    }
    
    //adds the recent property search to the database
    static func addPropertyHistory(history propertyHistory: PropertyHistory) -> Promise<Void> {
        return Promise {
            seal in
            if let user = FirebaseAuthManager.authRef.currentUser {
                ref.child("users").child(user.uid).child("history").child(propertyHistory.id.uuidString).setValue(propertyHistory.dictionary) {
                    (error, _) in
                    if let error = error {
                        seal.reject(error)
                    }
                    seal.fulfill(())
                }
            }
           
        }
    }
    
    //this function returns the property history into a dictonary object by using promise kit.
    static func readPropertyHisttory() -> Promise<[PropertyHistory]> {
        return Promise {
            seal in
            //checks for authenticated user.
            if let user = FirebaseAuthManager.authRef.currentUser {
                //reads the data from the db and encapsulates into an object, then it stores it on an array
                ref.child("users").child(user.uid).child("history").observeSingleEvent(of: .value) { (snapshot) in
                    do {
                        if let history = snapshot.value as? [String: [String: Any]] {
                            var historyTemp = [PropertyHistory]()
                            //loops through an dictionary
                            for (key, hotel) in history {
                                //print(key)
                                //print(favourite["hotelName"]!)
                                //creates an object
                                let historyObj: PropertyHistory = try PropertyHistory(id: key, hotelId: hotel["hotelId"]! as! String, hotelName: hotel["hotelName"]! as! String, hotelAddress: hotel["hotelAddress"]! as! String, imageUrl: hotel["imageUrl"]! as? String, imageDescription: hotel["imageDescription"] as? String, numbersOfNights: hotel["numbersOfNights"] as! Int, numbersOfRooms: hotel["numbersOfRooms"]! as! Int, totalAdults: hotel["totalAdults"]! as! Int, totalChildren: hotel["totalChildren"]! as! Int, price: hotel["price"]! as! Double)
                                //adds it to the array
                                historyTemp.append(historyObj)
                            }
                            seal.fulfill(historyTemp)
                            
                        } else {
                            //print("no data")
                            seal.fulfill([])
                        }
                    }
                    catch {
                        //this will catch a specific error relating to if a uuid has failed to convert from a string.
                        seal.reject(error)
                    }
                    //handles the error
                } withCancel: { error in
                    seal.reject(error)
                }
            } else {
                seal.reject(FireBaseRDError.userNotLoggedIn)
            }
        }
    }
}
