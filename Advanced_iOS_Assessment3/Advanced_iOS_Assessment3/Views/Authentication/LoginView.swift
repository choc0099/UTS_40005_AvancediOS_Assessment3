//
//  LoginView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 14/10/2023.
//

import SwiftUI

//this is a view for logging into the app
struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @EnvironmentObject var hotelMain: HotelBrowserMainViewModel
    //these other environment objects will be used to refresh the favourites and property history when logged in.
    @EnvironmentObject var hotelFavesVM: HotelFavouritesViewModel
    @EnvironmentObject var propertyHistoryVM: PropertyHistoryViewModel
    //this will determine if the button needs to be disabled, it will be disabled if there is no user inputs
    var buttonDisabled: Bool {
        if !email.isEmpty && !password.isEmpty {
            //this will enable the button.
            return false
        } else {
            return true
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Welcome to Hotel Browser").font(.title)
                
                TextField("Email Address", text: $email).autocapitalization(.none)
                SecureField("Password", text: $password)
                
                Button {
                    hotelMain.processLogin(email: email, password: password)
                } label: {
                    Text("Log In")
                }.disabled(buttonDisabled)
                
                //navigation link to the register view
                NavigationLink {
                    RegisterView()
                } label: {
                    Text("Register New Account")
                }
            }.padding()
                .alert(isPresented: $hotelMain.showAlert, content: {
                    Alert(
                        title: Text(hotelMain.alertTitle),
                        message: Text(hotelMain.alertMessage)
                        
                    )
                })
        }
    }
}

#Preview {
    LoginView()
}
