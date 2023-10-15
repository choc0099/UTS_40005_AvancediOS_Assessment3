//
//  HotelPropertySearch.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 26/9/2023.
//

import SwiftUI

//this is a struct that will be used to search for rooms to book with multiple criteria.
struct HotelPropertySearchView: View {
    //this is used to retrieve metadata
    @EnvironmentObject var hotelMain: HotelBrowserMainViewModel
    @StateObject var roomSearchVM = HotelPropertySearchViewModel()
    @State var isFromHistory: Bool
    @State var regionId: String
    @State var regionName: String
    @State var regionCoordinates: Coordinates
    @State var navActive: Bool = false
    //displays an alert to the user.
    @State var showAlert: Bool = false
    @State var alertTitle: String = ""
    @State var alertMessage: String = ""
   
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Check in and Check out Date Ranges") {
                    DatePicker("Check In Date", selection:  $roomSearchVM.checkInDate, displayedComponents: [.date])
                        //this will save to user defaults as the user updates the date.
                        .onChange(of: roomSearchVM.checkInDate, perform: { checkInDate in
                        saveToUserDefaults()
                    })
                    
                    DatePicker("Check Out Date", selection: $roomSearchVM.checkOutDate, displayedComponents: [.date])
                            //this will save to user defaults as the user updates the date.
                            .onChange(of: roomSearchVM.checkOutDate, perform: { checkOutDate in
                            saveToUserDefaults()
                        })
                }
                
                Section("Rooms") {
                    //allows the user to select numbers of rooms
                    Stepper("Numbers of Rooms: \(roomSearchVM.rooms.count)") {
                        roomSearchVM.incrementRooms()
                        //saves to userDefaults
                        saveToUserDefaults()
                    } onDecrement: {
                        roomSearchVM.decrementRooms()
                        saveToUserDefaults()
                    }
                }
                
                ForEach(roomSearchVM.rooms.indices, id: \.self) {
                    //allows the user to select numbers of rooms
                    roomIndex in
                    NavigationLink(destination: RoomFieldView(roomSearchVM: roomSearchVM, currentRoomId: roomSearchVM.rooms[roomIndex].id, regionId: regionId)) {
                        Text("Room \(roomIndex + 1)")
                    }
                }
                
                Section {
                    NavigationLink(destination: PropertySearchPreferencesView(roomSearchVM: roomSearchVM, regionId: regionId)) {
                        Text("Sort and Filter Results")
                    }
                }
                
            }.onAppear(perform: {
                //loads the search prefernces from userDefaults
                roomSearchVM.loadFromUserDefaults()
                //saves it to coreData
                CoreDataManager.saveNeighbourhoodSearch(searchType: .region, cameFromHistory: isFromHistory, regionId: regionId, regionName: regionName, regionCoordinates: regionCoordinates)
            })
            .toolbar {
                Button {
                    Task {
                        do {
                            //loads the response to the VM
                            try roomSearchVM.validate()
                            //saves to user defaults
                            saveToUserDefaults()
                            //proceeds to the next view.
                            navActive = true
                            await roomSearchVM.fetchResults(metaData: hotelMain.metaData, gaiaId: regionId)
                            
                        //displays an alert to the user if they did not input the stuffs correctly.
                        } catch QueryError.numbersOfRoomsNotEntered {
                            showAlert = true
                            alertTitle = "You have not entered how many rooms you need."
                            alertMessage = "You are requried to enter the numbers of room to get the best search results."
                        } catch QueryError.numbersOfAdultsNotEntered(let roomNumber) {
                            showAlert = true
                            alertTitle = "Please Check if there are adults entered in the rooms"
                            alertMessage = "You must declare how many adults in each room, you have not entered the numbers of adults in Room \(roomNumber)."
                        }
                        catch {
                            showAlert = true
                            alertTitle = "Something went wrong"
                            alertMessage = "Unable to process your request."
                        }
                        
                    }
                } label: {
                    Text("Continue")
                }
            }.navigationDestination(isPresented: $navActive) {
                PropertyResultsProcessingView(roomSearchVM: roomSearchVM, regionId: regionId, regionCoordinates: regionCoordinates)
            }.alert(isPresented: $showAlert) {
                Alert(
                    title: Text(alertTitle),
                    message: Text(alertMessage)
                )
            }
        }.navigationTitle("Search Property")
    }
    
    //helper function to save to user defaults.
    func saveToUserDefaults() {
        roomSearchVM.saveToUserDefaults(regionId: regionId, metaData: hotelMain.metaData)
    }
}

#Preview {
    //let emptyRegionResult: NeighborhoodSearchResult = NeighborhoodSearchResult()
    HotelPropertySearchView(isFromHistory: true, regionId: "", regionName: "", regionCoordinates: Coordinates(lat: -100, long: -100))
}
