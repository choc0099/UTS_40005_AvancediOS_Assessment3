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
    var body: some View {
        Form {
            Button("Log Out") {
                do {
                    try FirebaseAuthManager.logOut()
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
