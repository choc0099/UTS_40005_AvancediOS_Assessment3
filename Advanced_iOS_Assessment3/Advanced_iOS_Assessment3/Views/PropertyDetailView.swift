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
                    if let propertyInfo = propertyDetailsVM.propertyInfo {
                        //the first image from the image galary will be loaded on the hotel image view.
                        if let haveImage = propertyInfo.propertyGallery?.images {
                            HotelImageView(propertyImage: haveImage[0],  imageSize: 200, mapMode: false)
                        }
                        else {
                            //this will display a placeHolder image if there are no images in the galery
                            HotelImageView(imageSize: 200, mapMode: false)
                        }
                       
                        Spacer()
                        Text(propertyDetailsVM.hotelName).font(.title)
                        Spacer()
                        //this will display the hotel location details
                        
                        Text(propertyInfo.summary.location.address.addressLine).font(.headline)
                        MapImageView(mapImage: propertyInfo.summary.location.staticImage)
                        
                        if let description = propertyDetailsVM.propertyDescription {
                            Text("About This Property").font(.headline)
                            Text(description).font(.body)
                        }
                       
                        Spacer()
                      
                        Group {
                            if let policies = propertyInfo.summary.policies {
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
                    
                }.padding()
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
