//
//  AppIntents.swift
//  movi
//
//  Created by Alonso Huerta on 14/09/24.
//

import Foundation
import AppIntents

class AppStateManager {
    static let shared = AppStateManager()
    
    let navigationState = NavigationState()
    
    private init() { }
}

class NavigationState: ObservableObject {
    @Published var shouldNavigateToDestination = false
    @Published var amount: Double = 0.0
}

struct CreateECheq: AppIntent {
    static let title: LocalizedStringResource = "Create ECheq"
    
    @Parameter(title: "Amount")
    var amount: Double
    
    func perform() async throws -> some IntentResult {
        let navigationState = AppStateManager.shared.navigationState
                
                DispatchQueue.main.async {
                    navigationState.shouldNavigateToDestination = true
                    navigationState.amount = amount
                }
        return .result()
    }
    
    static let openAppWhenRun: Bool = true
}


struct eCheqShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(intent: CreateECheq(), phrases: ["Create \(.applicationName)", "Create mobi", "Demo it", "Create moubi", "Create mobi"], shortTitle: "Create mobi", systemImageName: "dollarsign.circle")
    }
}


import UIKit
import Intents

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        INPreferences.requestSiriAuthorization { status in
            if status == .authorized {
                print("Hey, Siri!")
            } else {
                print("Nay, Siri!")
            }
        }

        return true
    }
}
