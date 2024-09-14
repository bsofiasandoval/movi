//
//  ContentView.swift
//  movi
//
//  Created by Alonso Huerta on 14/09/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
            // Create mini-checks
            
            AccountView().tabItem { Label("Account", systemImage: "person") }.tag(1)
            // Minicheck list
            eCheqView().tabItem { Label("TODO", systemImage: "flowchart") }.tag(2)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
