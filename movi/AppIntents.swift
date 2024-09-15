//
//  AppIntents.swift
//  movi
//
//  Created by Alonso Huerta on 14/09/24.
//

import Foundation
import AppIntents

struct CreateECheq: AppIntent {
    static let title: LocalizedStringResource = "Create Mobi"
    
    func perform() async throws -> some IntentResult {
        print("HERE")
        return .result()
    }
    
    static let openAppWhenRun: Bool = true
}
