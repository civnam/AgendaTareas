//
//  CoreDataDosApp.swift
//  CoreDataDos
//
//  Created by MAC on 06/08/22.
//

import SwiftUI

@main
struct CoreDataDosApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
