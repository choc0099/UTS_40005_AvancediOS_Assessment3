//
//  SettingsView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 14/10/2023.
//

import SwiftUI

struct SettingsView: View {
    @State var showAlert: Bool = false
    @State var showPrompt: Bool = false
    @EnvironmentObject var hotelMain: HotelBrowserMainViewModel
    var body: some View {
        Form {
            Button("Log Out") {
                do {
                    try FirebaseAuthManager.logOut()
                    //clears the user from the main vm
                    hotelMain.destructUser()
                    

                }
                catch {
                    showAlert = true
                }
                
            }
        }.alert(isPresented: $showAlert, content: {
            Alert(title: Text("Unable to log out."))
        })
    }
}

#Preview {
    SettingsView()
}
