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
    @State var alertErrorTitle: String = ""
    @State var alertMessage: String = ""
    @State var settingAction: SettingAction = .clearUserDefaults
    //these are the enviromental object
    @EnvironmentObject var hotelMain: HotelBrowserMainViewModel
    @EnvironmentObject var hotelFavesVM: HotelFavouritesViewModel
    @EnvironmentObject var propertyHistoryVM: PropertyHistoryViewModel
    
    var body: some View {
        Form {
            //this will clear all your favourites
            Button("Clear All Favourites") {
                showPrompt = true
                settingAction = .clearFavourites
                //renders the prompt message
                renderPromptMessage()
            }
            //this will clear all your property search history.
            Button("Clear All Recents") {
                showPrompt = true
                settingAction = .clearPropertyHistory
                //renders the prompt message
                renderPromptMessage()
            }
            //this will clear data that is stored locally on the search view
            Button("Clear Search History") {
                showPrompt = true
                settingAction = .clearSearchHistory
                renderPromptMessage()
            }
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
                    alertErrorTitle = "Unable to log out."
                    
                }
                
            }
        }.alert(isPresented: $showAlert, content: {
            Alert(title: Text(alertTitle))
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
        case .clearFavourites:
            alertTitle = "Are you sure you want to clear all your hotel favourites?"
            alertMessage = "Your hotel favourites will no longer be stored on the database, these can't be undone."
        case .clearPropertyHistory:
            alertTitle = "Are you sure you want to clear all your recents?"
            alertMessage = "Your recents that have the hotel details including the name of the hotel, how many nights you want to stay in, the calculated price, how many rooms you want and the number of people will no longer be stored on the database, these can't be undone."
        case .clearSearchHistory:
            alertTitle = "Are you sure you want to clear all your search history from the search view?"
            alertMessage = "This will clear your recent searches that is stored locally on this device."
        }
    }
    
    //this will prefrom specific actions based on what button has been pressed.
    func preformAction() {
        
        switch settingAction {
        case .clearUserDefaults:
            print("Pressed (clear from user defaults)")
            UserDefaultsManager.removePreferences()
        case .clearFavourites:
            print("Pressed (clear all favourites)")
            clearFavourites()
        case .clearPropertyHistory:
            print("Pressed (clear all recents)")
            clearRecents()
        case .clearSearchHistory:
            print("Pressed (clear search history)")
            clearSearchHistory()
        }
        
    }
    
    func clearFavourites() {
        FirebaseRDManager.removeAllFavouritesFromDB()
            .done {
                //refreshes the favourites vm
                hotelFavesVM.fetchFavourites()
            }
            .catch { error in
            print(error.localizedDescription)
            showAlert = true
            alertTitle = "Unable to clear all favourites."
        }
    }
    
    func clearRecents() {
        FirebaseRDManager.removeAllPropertyHistoryFromDB()
            .done {
                //refreshes the vm
                propertyHistoryVM.fetchHistory()
            }
            .catch { error in
            print(error.localizedDescription)
            showAlert = true
            alertTitle = "Unable to clear all property recents."
        }
    }
    //helper function to clear search history from CoreData
    func clearSearchHistory() {
        do {
            try CoreDataManager.clearAllSearchHistory()
        } catch {
            print(error.localizedDescription)
            showAlert = true
            alertTitle = "Unable to clear search history"
        }
    }
}

#Preview {
    SettingsView()
}
