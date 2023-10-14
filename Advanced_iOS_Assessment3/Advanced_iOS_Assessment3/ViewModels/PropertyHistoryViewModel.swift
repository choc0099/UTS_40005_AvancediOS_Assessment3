//
//  PropertyHistoryViewModel.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 13/10/2023.
//

//this is a view model that will be used to display property history stored from the database
import Foundation
class PropertyHistoryViewModel: ObservableObject {
    @Published var propertyHistory = [PropertyHistory]()
    @Published var status: HotelStatus = .active
    @Published var showAlert: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    
    //this is a computed property that sorts the property history into decending order.
    var sortedHistory: [PropertyHistory] {
        return propertyHistory.reversed()
    }
    
    
    //retrieves the property history from the database
    func fetchHistory() {
        FirebaseRDManager.readPropertyHisttory()
            .done { historyList in
                //adds it to the view model array
                self.propertyHistory = historyList
                
                //this will display a no favourites message to the user if there are no favourites fouond from the database.
                if self.propertyHistory.isEmpty {
                    self.status = .noHistory
                } else {
                    self.status = .active
                }
            }
            .catch { error in
                //changes the status to no history
                self.status = .noHistory
                print(error)
                print(error.localizedDescription)
            }
        
    }
    
    func removeHistoryItem(uuId: UUID) {
        FirebaseRDManager.removePropertyHistoryItemFromDB(id: uuId)
            .done {
                print("\(uuId) Removed from history")
            }
            .catch { error in
                print(error)
                print(error.localizedDescription)
                //displays an alert to the user
                self.showAlert = true
                self.alertTitle = "An error has occurred. "
                self.alertMessage = "Unable to remove this favourite."
            }
    }
}
