//
//  ChildrenFieldView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 27/9/2023.
//

import SwiftUI

struct ChildrenFieldView: View {
    @ObservedObject var roomSearchVM: HotelPropertySearchViewModel
    @State var currentRoomId: UUID
    @State var currentChildId: UUID
    @State var ageInput: Int = 0;
    
    var body: some View {
        Stepper("Age: \(ageInput)", value: $ageInput).onChange(of: ageInput, perform: { childAge in
            //updates it from the model side
            roomSearchVM.setChildrenAge(age: childAge, roomId: currentRoomId, childId: currentChildId)
        }).onAppear(perform: {
            //this will display the child's age onto the view that has been set previously from the VM
            ageInput = try! roomSearchVM.findChildrenById(roomId: currentRoomId, childrenId: currentChildId).age
        })
    }
}


struct ChildrenFieldView_Previews: PreviewProvider {
    static var previews: some View {
        let room: Room = Room(adults: 1, children: [Children(age: 1)])
        ChildrenFieldView(roomSearchVM: HotelPropertySearchViewModel(), currentRoomId: room.id, currentChildId: room.children[0].id )
    }
}
