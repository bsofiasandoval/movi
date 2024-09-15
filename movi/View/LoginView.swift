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
            ZStack {
                Color(hex: "#0d507a")
                    .ignoresSafeArea()
                
                VStack(alignment: .center) {
                    Image("MoBi Logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 250, height: 200) // Adjust these values as needed
                        .padding(.top, 40)
                        .padding(.bottom, 40)
                    
<<<<<<< HEAD
                    Form {
                        Section {
                            HStack {
                                Image(systemName: "person")
                                TextField("User", text: $user, prompt: Text("Username"))
                            }
                            HStack {
                                Image(systemName: "key")
                                SecureField("Password", text: $password, prompt: Text("Password"))
                            }
                        }
                        
                        Section {
                            NavigationLink("Login", destination: {
                                // TODO credential validation
                                ContentView(customer: Customer(_id: "66e613bc9683f20dd5189c26", first_name: "Alonso", last_name: "Huerta", address: Address(street_number: "333", street_name: "Street Name", city: "MTY", state: "NL", zip: "96400")), accounts: [Account(_id: "66e62ed29683f20dd5189c6e", type: "balance", nickname: "Debit", rewards: 0, balance: 1000.0, account_number: nil, customer_id: "66e613bc9683f20dd5189c26")])
                                    .navigationBarBackButtonHidden()
                            })
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                   
                    .background(Color.clear)
=======
                    NavigationLink("Login", destination: {
                        // TODO credential validation
                        ContentView(customer: Customer(_id: "66e613bc9683f20dd5189c26", first_name: "Alonso", last_name: "Huerta", address: Address(street_number: "333", street_name: "Street Name", city: "MTY", state: "NL", zip: "96400")), accounts: [Account(_id: "66e62ed29683f20dd5189c6e", type: "balance", nickname: "Debit", rewards: 0, balance: 0.0, account_number: nil, customer_id: "66e613bc9683f20dd5189c26")])
                            .navigationBarBackButtonHidden()
                    })
                    .buttonStyle(.borderless)
>>>>>>> 2a5530b (asdf)
                }
            }
        }
    }
}

// ... (Color extension remains unchanged)

#Preview {
    LoginView()
    
    .environmentObject(NavigationState())
}
