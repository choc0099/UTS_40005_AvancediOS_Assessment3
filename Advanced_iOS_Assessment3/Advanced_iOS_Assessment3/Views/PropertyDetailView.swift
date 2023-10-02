//
//  PropertyDetailView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 1/10/2023.
//

import SwiftUI

struct PropertyDetailView: View {
    @EnvironmentObject var hotelMain: HotelBrowserMainViewModel
    @StateObject var propertyDetailsVM: HotelPropertyDetailViewModel = HotelPropertyDetailViewModel()
    @State var propertyId: String
    
    var body: some View {
        Group {
            ScrollView {
                VStack(spacing: 20) {
                    //HotelImageView(propertyImage: propertyDetailsVM.propertyInfo?.propertyGallery?.images[0], imageSize: imageSize: 200, mapMode: false)
                    Spacer()
                    Text(propertyDetailsVM.hotelName).font(.title)
                    Spacer()
                    Text("About This Property").font(.headline)
                    Text(propertyDetailsVM.propertyDescription).font(.body)
                    Group {
                        if let policies = propertyDetailsVM.propertyInfo?.summary.policies {
                            Text("Policies").font(.subheadline)
                            if let checkInInstructions = policies.checkInInstructions {
                                Text("Check in Instructions").font(.subheadline)
                                ForEach(checkInInstructions, id: \.self) {
                                    instruction in Text(instruction).font(.body)
                                }
                            }
                            
                            if let needToKnow = policies.needToKnow?.body {
                                Text("Need to know").font(.subheadline)
                                ForEach(needToKnow, id: \.self) {
                                    message in Text(message).font(.body)
                                }
                            }
                            
                            if let pets = policies.pets?.body  {
                                Text("Pets").font(.subheadline)
                                ForEach(pets, id: \.self) {
                                    petMessage in
                                    Text(petMessage)
                                }
                            }
                        }
                        
                    }
                    
                    
                }
            }
            
        }.onAppear(perform: {
            if let haveMetaData = hotelMain.metaData {
                Task {
                    //loads the property details from the APIa
                    await propertyDetailsVM.fetchPropertyDetails(propertyId:propertyId, metaData: haveMetaData)
                }
            }
        })
    }
}

#Preview {
    PropertyDetailView(propertyId: "")
}
