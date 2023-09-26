//
//  ContentView.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 18/9/2023.
//

import SwiftUI
import CoreImage
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var hotelMain: HotelBrowserMainViewModel

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    @State var searchText: String = ""

    var body: some View {
        
        TabView {
            
            NavigationStack {
                //this is for the search fields to search for a query including hotels and regions
                HStack(spacing: 5) {
                    Image(systemName: "magnifyingglass")
                    TextField("Search", text: $searchText)
                }.padding().background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding()
                List {
                    Section("Hotel Suggestions") {
                        ForEach(hotelMain.hotelSearchResults) { hotel in
                            if hotel.type == "HOTEL" {
                                if let haveAddress = hotel.hotelAddress {
                                    Text(hotel.regionNames.fullName)
                                }
                            }
                        }
                    }
                    Section("Regions and Neighbourhoods") {
                        ForEach(hotelMain.regionSearchResults) {
                            region in
                            if region.type != "HOTEL" {
                                Text(region.regionNames.primaryDisplayName)
                            }
                        }
                        
                    }
                }
                .toolbar {
                    Button {
                        Task {
                            //loads the list of hotels using the api
                           await hotelMain.loadRegions()
                        }
                        
                    } label: {
                        Text("Load List")
                    }
                }
            }.tabItem {
                Label("Home", systemImage: "house.fill")
            }
            
            RegionsView().tabItem {
                Label("Regions", systemImage: "globe")
            }
        }.padding()
        
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).environmentObject(HotelBrowserMainViewModel())
    }
}
