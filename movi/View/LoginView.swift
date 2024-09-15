//
//  LoginView.swift
//  movi
//
//  Created by Alonso Huerta on 14/09/24.
//

import SwiftUI

struct LoginView: View {
    @State private var user: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                Form {
                    HStack {
                        Spacer()
                        Label("MoBi", systemImage: "tray")
                            .font(.title)
                        Spacer()
                    }
                    .padding()
                    HStack {
                        Image(systemName: "person")
                        TextField("User", text: $user, prompt: Text("Username"))
                    }
                    HStack {
                        Image(systemName: "key")
                        TextField("Password", text: $user, prompt: Text("Password"))
                    }
                    
                    NavigationLink("Login", destination: {
                        // TODO credential validation
                        ContentView(customer: Customer(_id: "66e613bc9683f20dd5189c26", first_name: "Alonso", last_name: "Huerta", address: Address(street_number: "333", street_name: "Street Name", city: "MTY", state: "NL", zip: "96400")), accounts: [Account(_id: "66e62ed29683f20dd5189c6e", type: "balance", nickname: "Debit", rewards: 0, balance: 1000.0, account_number: nil, customer_id: "66e613bc9683f20dd5189c26")])
                            .navigationBarBackButtonHidden()
                    })
                    .buttonStyle(.borderless)
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
