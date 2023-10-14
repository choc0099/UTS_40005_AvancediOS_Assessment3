//
//  Advanced_iOS_Assessment3Tests.swift
//  Advanced_iOS_Assessment3Tests
//
//  Created by Christopher Averkos on 18/9/2023.
//

import XCTest
import FirebaseCore
import FirebaseAuth
import PromiseKit

@testable import Advanced_iOS_Assessment3

final class Advanced_iOS_Assessment3Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //FirebaseApp.configure()
        super.setUp()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    /*
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testHotelDetails() throws {
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }*/
    
    func testLogin() throws {
        let expectation = XCTestExpectation(description: "log in expectation")
        var testedEmail: String = ""
       
        FirebaseAuthManager.login(email: "choclate00@live.com", password: "abc123") .done { account in
            var accountEmail = account.user.email
            print("running login test")
            if let haveEmail = accountEmail{
               testedEmail = haveEmail
                expectation.fulfill()
            }
        }
        .catch { error in
            switch error {
            case AuthError.invalidCredentials:
                print("invalid username or password")
            default:
                print(error)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
        XCTAssertEqual(testedEmail, "choclate00@live.com")
    }
    
    //tests the register feature
    func testRegister() {
        //this is used for asynchronous tasks.
        var retrievedEmail: String = ""
        let expectation = XCTestExpectation(description: "Register new user")
        FirebaseAuthManager.registerAccount(email: "pieface012@gmail.com", password: "abc123", confirmPassword: "abc123")
            .done { authResult in
                if let loggedInEmail = authResult.user.email {
                    print("Registration and login sucessful")
                    retrievedEmail = loggedInEmail
                    expectation.fulfill()
                }
            } .catch { error in
                switch error {
                case AuthError.passwordNotMatch:
                    print("password not match.")
                case AuthError.unknown:
                    print("An unkown error occurred.")
                default:
                    print(error)
                }
                expectation.fulfill()
            }
        //waits for the proccess to be complete over the network.
        wait(for: [expectation])
        XCTAssertEqual(retrievedEmail, "pieface012@gmail.com")
    }

}
