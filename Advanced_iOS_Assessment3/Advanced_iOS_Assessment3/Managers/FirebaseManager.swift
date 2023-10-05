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
    static let ref: DatabaseReference = Database.database().reference(fromURL: "https://hotel-browser-default-rtdb.firebaseio.com/")
    
    //tests writing data to database
    static func testWrite() {
        //self.ref.child("favourite").setValue("The Cigarettes Hotel", forKey: "hotelName")
        //self.ref.child("favourite").setValue("http://www.google.com", forKey: "imageUrl")
        self.ref.setValue("Cigarettes")
    }
    
}
