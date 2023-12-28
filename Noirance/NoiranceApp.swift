//
//  NoiranceApp.swift
//  Noirance
//
//  Created by Diki Dwi Diro on 28/12/23.
//

import SwiftUI

@main
struct NoiranceApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            MainView()
        }
    }
}
