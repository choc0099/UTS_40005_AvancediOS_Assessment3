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
    
    init() {
        fetchHistory()
    }
    
    //retrieves the property history from the database
    func fetchHistory() {
        FirebaseManager.readPropertyHisttory()
            .done { historyList in
                //adds it to the view model array and sorts it in reverse order which allows to view the most recent one on the top
                self.propertyHistory = historyList.reversed()
            }
            .catch { error in
                print(error)
                print(error.localizedDescription)
            }
    }
}
