//
//  PropertyDetailView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 1/10/2023.
//

import SwiftUI

struct PropertyDetailView: View {
    @EnvironmentObject var hotelMain: HotelBrowserMainViewModel
    @EnvironmentObject var hotelFavesVM: HotelFavouritesViewModel
    @ObservedObject var propertyDetailsVM: HotelPropertyDetailViewModel
    //these are optional varibles which will be used to record searched property history into the database.
    @State var price: Double?
    @State var totalAdults: Int?
    @State var totalChildren: Int?
    @State var numbersOfNights: Int?
    @State var numbersOfRooms: Int?
    //@State var checkInDate: Date?
    //@State var checkOutDate: Date?
    
    
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
                        Spacer()
                        Button  {
                            //process the favourite task whether to add or remove from favourites.
                            propertyDetailsVM.manageFavourite()
                            //refreshes the hotelFavourites VM
                            hotelFavesVM.fetchFavourites()
                        } label: {
                            HStack(spacing: 10) {
                                Image(systemName: propertyDetailsVM.isFavourite ? "heart.fill" : "heart")
                                Text(propertyDetailsVM.isFavourite ? "Remove from favourites" : "Add to Favourites")
                            }
                            
                        }
                            
                        Spacer()
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
            }.onAppear(perform: {
                propertyDetailsVM.checkFavourite()
                
                //this will store the property history into the database, using multiple unwrapings.
                if let numbersOfNights = numbersOfNights {
                    if let totalAdults = totalAdults {
                        if let totalChildren = totalChildren {
                            if let price = price {
                                if let numbersOfRooms = numbersOfRooms {
                                    propertyDetailsVM.savePropertyHistory(numbersOfNights: numbersOfNights, numbersOfRooms: numbersOfRooms, totalAdults: totalAdults, totalChildren: totalChildren, price: price)
                                }
                                
                            }
                        }
                    }
                    //it will not store to the database if the user viewed the Hotel Details coming from favourites or the history view.
                }
            }).alert(isPresented: $propertyDetailsVM.showAlert, content: {
                Alert(
                    title: Text(propertyDetailsVM.alertTitle),
                    message: Text(propertyDetailsVM.alertMessage)
                )
            })
            
        }
    }
}
