//
//  moviApp.swift
//  movi
//
//  Created by Alonso Huerta on 14/09/24.
//

import SwiftUI
import SwiftData

// MARK: - Global Constants

let baseURL = "http://api.nessieisreal.com"
let key = "c4829ff50727c58165e22d423e3c4e9f"
let MoBiId = "66e614079683f20dd5189c28"

@main
struct moviApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            LoginView()
        }
        .modelContainer(sharedModelContainer)
    }
}
