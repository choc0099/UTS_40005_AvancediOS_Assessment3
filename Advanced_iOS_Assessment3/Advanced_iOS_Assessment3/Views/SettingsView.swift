//
//  SettingsView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 14/10/2023.
//

import SwiftUI

enum SettingAction {
    case clearUserDefaults
    case clearSearchHistory
    case clearFavourites
    case clearPropertyHistory
}

struct SettingsView: View {
    @State var showAlert: Bool = false
    @State var showPrompt: Bool = false
    @State var alertTitle: String = ""
    @State var alertMessage: String = ""
    @State var settingAction: SettingAction = .clearUserDefaults
    @EnvironmentObject var hotelMain: HotelBrowserMainViewModel
    var body: some View {
        Form {
            //this will clear stored search preferneces including price filtering and numbers of rooms.
            Button("Clear Search Preferences") {
                showPrompt = true
                settingAction = .clearUserDefaults
                //renders the alert message
                renderPromptMessage()
            }
            Button("Log Out") {
                do {
                    //brings the search status back to welcom so the search history is displayed when the user logs back on.
                    hotelMain.searchStatus = .welcome
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
        .alert(isPresented: $showPrompt, content: {
            Alert(
                title:  Text(alertTitle),
                message: Text(alertMessage),
                  primaryButton: .destructive(
                    Text("Clear"), action: {
                        preformAction()
                    }), secondaryButton: .cancel()
            )
        })
    }
    
    
    //this will display different messages for each actions.
    func renderPromptMessage() {
        switch settingAction {
        case .clearUserDefaults:
            alertTitle = "Are you sure you want to clear property search prefernce from user defaults?"
            alertMessage = "This will include your check in dates, check out dates, numbers of rooms, numbers of adults, numbers of children sort and filter prefernces. These changes can't be undone."
        default:
            alertTitle = ""
            alertMessage = ""
        }
    }
    
    //this will prefrom specific actions based on what button has been pressed.
    func preformAction() {
        
        switch settingAction {
        case .clearUserDefaults:
            print("Pressed (clear from user defaults)")
            UserDefaultsManager.removePreferences()
        default:
            return
        }
        
    }
}

#Preview {
    SettingsView()
}
