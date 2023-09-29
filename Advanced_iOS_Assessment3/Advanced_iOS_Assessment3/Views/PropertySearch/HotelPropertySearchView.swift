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
    @State var region: NeighborhoodSearchResult
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
                    DatePicker("Check Out Date", selection: $roomSearchVM.checkOutDate, displayedComponents: [.date])
                }
                
                Section("Rooms") {
                    //allows the user to select numbers of rooms
                    Stepper("Numbers of Rooms: \(roomSearchVM.numbersOfRooms)") {
                        roomSearchVM.incrementRooms()
                    } onDecrement: {
                        roomSearchVM.decrementRooms()
                    }
                }
                
                ForEach(roomSearchVM.rooms) {
                    //allows the user to select numbers of rooms
                    room in
                    NavigationLink(destination: RoomFieldView(roomSearchVM: roomSearchVM, currentRoomId: room.id)) {
                        Text("Room \(room.index)")
                    }
                }
            }.onAppear(perform: {
                if let haveRegion = region.gaiaId {
                    print(haveRegion)
                    //saves it to coreData
                    CoreDataManager.saveNeighbourhoodSearch(neighbourhoodResult: region)
                }
            })
            .toolbar {
                Button {
                    if let haveMetaData = hotelMain.metaData {
                        
                            Task {
                                do {
                                    //loads the response to the VM
                                    try roomSearchVM.validate()
                                    //proceeds to the next view.
                                    navActive = true
                                    await roomSearchVM.fetchResults(metaData: haveMetaData, gaiaId: region.gaiaId!)
                                    
                                //displays an alert to the user if they did not input the stuffs correctly.
                                } catch QueryError.numbersOfRoomsNotEntered {
                                    showAlert = true
                                    alertTitle = "You have not entered how many rooms you need."
                                    alertMessage = "You are requried to enter the numbers of room to get the best search results."
                                } catch QueryError.numbersOfAdultsNotEntered(let roomNeeded) {
                                    showAlert = true
                                    alertTitle = "Please Check if there are adults entered in the rooms"
                                    alertMessage = "You must declare how many adults in each room, you have not entered the numbers of adults in Room \(roomNeeded.index)."
                                }
                                catch {
                                    showAlert = true
                                    alertTitle = "Something went wrong"
                                    alertMessage = "Unable to process your request."
                                }
                                
                            }
                    }
                    else {
                        print("No metaData")
                    }
                } label: {
                    Text("Continue")
                }
            }.navigationDestination(isPresented: $navActive) {
                PropertyResultsProcessingView(roomSearchVM: roomSearchVM, region: region)
            }.alert(isPresented: $showAlert) {
                Alert(
                    title: Text(alertTitle),
                    message: Text(alertMessage)
                )
            }
        }.navigationTitle("Search Property")
    }
}

#Preview {
    //let emptyRegionResult: NeighborhoodSearchResult = NeighborhoodSearchResult()
    HotelPropertySearchView(region: NeighborhoodSearchResult(gaiaId: "6047790"))
}
