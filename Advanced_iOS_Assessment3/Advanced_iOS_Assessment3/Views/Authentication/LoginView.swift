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
                }
                
                //navigation link to the register view
                NavigationLink {
                    RegisterView()
                } label: {
                    Text("Register Now")
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