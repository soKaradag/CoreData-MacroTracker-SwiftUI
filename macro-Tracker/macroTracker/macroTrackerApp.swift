//
//  macroTrackerApp.swift
//  macroTracker
//
//  Created by Serdar Onur KARADAĞ on 31.08.2022.
//

import SwiftUI

@main
struct macroTrackerApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                
                GoalsView()
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .tabItem{
                        Label("Goals", systemImage: "arrowshape.zigzag.right")
                    }

                
                ContentView()
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .tabItem{
                        Label("Foods", systemImage: "fork.knife")
                    }
            }
        }
    }
}
