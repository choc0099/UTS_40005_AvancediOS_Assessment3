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
    var body: some View {
        
        TabView {
            SearchView().tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
            
            RegionsView().tabItem {
                Label("Settings", systemImage: "globe")
            }
            HotelPropertySearchView(region: NeighborhoodSearchResult(gaiaId: "6047790")).tabItem {
                Label("text", systemImage: "")
            }
        }.onAppear {
            //loads the hotel metaData
            hotelMain.initialiseMetaData()
        }
    }
        
    
    /*
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
    }*/
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
