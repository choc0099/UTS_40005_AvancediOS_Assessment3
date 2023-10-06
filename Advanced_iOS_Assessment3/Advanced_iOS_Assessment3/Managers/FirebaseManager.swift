//
//  FirebaseManager.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 5/10/2023.
//

import Foundation
import FirebaseCore
import FirebaseDatabase
import FirebaseFirestore
//this is a class to store and retrieve data from the Firebase server.

enum FireBaseRDError: Error {
    case deleteFailed
    case readFailed
}

class FirebaseManager {
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
    
    static func readFavourites() throws -> [HotelFavourite] {
        //this is a boolean to determine if there is an error reading data from the db
        var isError: Bool = false
        //this is an array of favourites
        var favouritesTemp: [HotelFavourite] = []
        //reads the data from the db and encapsulates into an object, then it stores it on an array
        ref.child("hotelMain").child("favourites").observeSingleEvent(of: .value, with: { (snapshot) in
            if let favourites = snapshot.value as? [String: [String: String]] {
                //loops through an dictionary
                for (key, favourite) in favourites {
                    //creates an object
                    let favouriteObj = HotelFavourite(hotelId: key, hotelName: favourite["hotelName"]!, hotelAddress: favourite["hotelAddress"]!, imageUrl: favourite["imageUrl"]!, imageDescription: favourite["imageDescription"]!)
                    //adds it to the array
                    favouritesTemp.append(favouriteObj)
                    
                }
            }
        }) { (error) in
            isError = true
        }
        
        if isError {
            throw FireBaseRDError.readFailed
        }
        
        return favouritesTemp
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
    
    static func saveFavouriteToDB(favourite: HotelFavourite) throws {
        ref.child("hotelMain").child("hotelFavourites").setValue(favourite.dictionary)
    }
    
    static func removeFavouriteFromDB(propertyId: String) throws {
        //removes the record from DB
        //this is a boolean to determine whether an error has occurred.
        var isError: Bool = false
        ref.child("hotelMain").child("hotelFavourites").child(propertyId).removeValue {
            (error, favourite) in
            if let error = error {
                isError = true
            }
        }
        
        //throws an error based on the boolean isError status
        if isError {
            throw FireBaseRDError.deleteFailed
        }
    }
}
