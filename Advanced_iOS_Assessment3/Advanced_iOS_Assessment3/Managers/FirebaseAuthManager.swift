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

enum AuthError: Error {
    case passwordNotMatch
    case invalidCredentials
    case unknown
}

class FirebaseAuthManager {
    
    //this is an refernce to the authentication stuff that is shared throughout views and viewmodels.
    static var authRef = Auth.auth()
    
    //logins to the user account
    static func login(email: String, password: String) -> Promise<AuthDataResult> {
        return Promise {
            seal in
            authRef.signIn(withEmail: email, password: password) {
                (authResult, error) in
                print("logging in")
                //prints a result for testing pruposes
                if let authResult = authResult {
                    seal.fulfill(authResult)
                    print("logged in as \(authResult.user.email!)" )
                }
                else {
                    //print("Invalid credentials")
                    seal.reject(AuthError.invalidCredentials)
                    
                }
                
                if let error = error {
                    //print(error)
                    //print(error.localizedDescription)
                    seal.reject(error)
                }
            }
        }
    }
    
    //creates a new account onto the system
    static func registerAccount(email: String, password: String, confirmPassword: String) -> Promise<AuthDataResult>  {
        return Promise {
            seal in
            //checks if both password field matches.
            if password == confirmPassword {
                //processes the registration process
                self.authRef.createUser(withEmail: email, password: password) {
                    (authResult, error) in
                    if let authResult = authResult {
                        //allows it to fulfil, then it will automatically log in to the system.
                        seal.fulfill(authResult)
                    }
                    else {
                        if let error = error {
                            seal.reject(error)
                        } else {
                            seal.reject(AuthError.unknown)
                        } //throws an undifened error if no errors are thrown.
                        
                    }
                    
                }
            }
            else {
                //throws an error
                seal.reject(AuthError.passwordNotMatch)
            }
        }
        
    }
    
 
}
