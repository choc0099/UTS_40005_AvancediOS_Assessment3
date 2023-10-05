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
    
}
