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
    @EnvironmentObject var hotelMain: HotelBrowserMainViewModel
    
    //private var items: FetchedResults<Item>
    var body: some View {
        if !hotelMain.isLoggedIn {
            LoginView()
        } else {
            InSessionView()
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
