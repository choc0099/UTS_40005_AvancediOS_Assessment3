//
//  RegisterView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 14/10/2023.
//

import SwiftUI

struct RegisterView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @EnvironmentObject var hotelMain: HotelBrowserMainViewModel
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Email Address", text: $email).autocapitalization(.none)
                SecureField("Password", text: $password)
                SecureField("Confirm Password", text: $confirmPassword)
                Button {
                    //processes the registration process
                    Task {
                        hotelMain.processRegister(email:email, password:password, confirmPassword: confirmPassword)
                        //clears the feilds if there was an error
                        email = ""
                        password = ""
                        confirmPassword = ""
                    }
                } label: {
                    Text("Submit")
                }
            }
        
        }.padding().navigationTitle("Register")
    }
}

#Preview {
    RegisterView()
}
