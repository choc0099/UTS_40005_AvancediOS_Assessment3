//
//  ChildrenFieldView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 27/9/2023.
//

import SwiftUI

struct ChildrenFieldView: View {
    @ObservedObject var roomSearchVM: HotelPropertySearchViewModel
    //passes the UUID's from the rooms and child instead of using Bindings but interacting with the VM.
    @State var currentRoomId: UUID
    @State var currentChildId: UUID
    @State var ageInput: Int = 0;
    //this is used to save to userDefaults
    @State var regionId: String
    @EnvironmentObject var hotelMain: HotelBrowserMainViewModel
    
    var body: some View {
        Stepper("Age: \(ageInput)", value: $ageInput).onChange(of: ageInput, perform: { childAge in
            //updates it from the model side
            roomSearchVM.setChildrenAge(age: childAge, roomId: currentRoomId, childId: currentChildId)
            saveToUserDefaults()
        }).onAppear(perform: {
            //this will display the child's age onto the view that has been set previously from the VM
            ageInput = try! roomSearchVM.findChildrenById(roomId: currentRoomId, childrenId: currentChildId).age
        })
    }
    
    //this is a helper function to save to user defaults to the roomSearchVM on editing events.
    func saveToUserDefaults() {
        roomSearchVM.saveToUserDefaults(regionId: regionId, metaData: hotelMain.metaData)
        
    }
}


struct ChildrenFieldView_Previews: PreviewProvider {
    static var previews: some View {
        let room: Room = Room(adults: 1, children: [Children(age: 1)])
        ChildrenFieldView(roomSearchVM: HotelPropertySearchViewModel(), currentRoomId: room.id, currentChildId: room.children[0].id, regionId: "")
    }
}
