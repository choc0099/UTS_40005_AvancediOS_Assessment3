//
//  Advanced_iOS_Assessment3App.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 18/9/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseDatabase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


@main
struct Advanced_iOS_Assessment3App: App {
    
    
    let persistenceController = PersistenceController.shared
    @StateObject var hotelMain: HotelBrowserMainViewModel = HotelBrowserMainViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegat
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext).environmentObject(hotelMain)
        }
    }
}
