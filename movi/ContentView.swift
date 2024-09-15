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
        TabView {
            AccountView().tabItem { Label("Account", systemImage: "person") }.tag(1)
            eCheqView().tabItem { Label("eCheq", systemImage: "flowchart") }.tag(2)
            ExploreView().tabItem { Label("Explore", systemImage: "magnifyingglass")}.tag(3)
          
           
            
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
