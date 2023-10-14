//
//  FirebaseAuthManager.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 14/10/2023.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase
import PromiseKit

//this is a class for handling authentication

enum AuthStatus: Error {
    case success
    case invalidCredentials
    case unknown
}

class FirebaseAuthManager {
    
    //logins to the user account
    static func login(email: String, password: String) -> Promise<AuthDataResult> {
        return Promise {
            seal in
            Auth.auth().signIn(withEmail: email, password: password) {
                (authResult, error) in
                print("logging in")
                //prints a result for testing pruposes
                if let authResult = authResult {
                    seal.fulfill(authResult)
                    print("logged in as \(authResult.user.email!)" )
                }
                else {
                    //print("Invalid credentials")
                    seal.reject(AuthStatus.invalidCredentials)
                    
                }
                
                if let error = error {
                    //print(error)
                    //print(error.localizedDescription)
                    seal.reject(error)
                }
            }
        }
    }
}
