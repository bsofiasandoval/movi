//
//  ContentView.swift
//  movi
//
//  Created by Alonso Huerta on 14/09/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var customer: Customer
    var accounts: [Account]
    
    

    
    var body: some View {
        TabView {
            AccountView(customer: customer, accounts: accounts).tabItem { Label("Account", systemImage: "person") }.tag(1)
            eCheqView(customer: customer, accounts: accounts).tabItem { Label("eCheq", systemImage: "flowchart") }.tag(2)
            ExploreView().tabItem { Label("Explore", systemImage: "magnifyingglass")}.tag(3)

        }
        
    }
}

#Preview {
    ContentView(customer: Customer(_id: "66e613bc9683f20dd5189c26", first_name: "Alonso", last_name: "Huerta", address: Address(street_number: "333", street_name: "Street Name", city: "MTY", state: "NL", zip: "96400")), accounts: [Account(_id: "66e62ed29683f20dd5189c6e", type: "balance", nickname: "Debit", rewards: 0, balance: 1000.0, account_number: nil, customer_id: "66e613bc9683f20dd5189c26")])
        .modelContainer(for: Item.self, inMemory: true)
}
