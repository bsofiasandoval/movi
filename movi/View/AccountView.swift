//
//  AccountView.swift
//  movi
//
//  Created by Alonso Huerta on 14/09/24.
//

import SwiftUI

struct AccountView: View {
    var customer: Customer
    var lastFour: String = "0773"
    var currentBalance: Double = 150
    
    @State private var accounts:[Account] = []
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                        Text("Good Morning, \(customer.first_name)!")
                            .font(.system(size: 30))
                            .multilineTextAlignment(.center)
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height / 2 )
                    .background(Color(hex: "#0d507a"))
                }
                .frame(height: UIScreen.main.bounds.height / 3)
                
               
                VStack(spacing: 14) {
                    HStack{
                        Text("Accounts")
                            .font(.title2)
                            .fontWeight(.regular)
                        Spacer()
                    }
                       
                    VStack{
                        ForEach(accounts, id: \._id) { account in
                            HStack {
                                
                                VStack{
                                    HStack{
                                        Text("TOTAL BALANCE (...\(lastFour))")
                                        Spacer()
                                    }
                                    HStack{
                                        Spacer()
                                        VStack{
                                            HStack{
                                                Text("$")
                                                    .font(.system(size: 30))
                                                Text(account.balance, format: .number.rounded(increment: 0.01))
                                                    .font(.system(size: 30))
                                                
                                                
                                                
                                            }
                                            Text("Available Balance")
                                                .font(.footnote)
                                        }
                                    }
                                }
                                Spacer()
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .frame(height: 140)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 100)
                        }
                    }
                    .onAppear(perform: {
                        getAccounts(customerId: "66e613bc9683f20dd5189c26") { result in
                            switch result {
                            case .success(let accounts):
                                // Handle the array of accounts
                                DispatchQueue.main.async {
                                    // For example, print account details
                                    self.accounts = accounts
                                    for account in accounts {
                                        print("Account ID: \(account._id)")
                                        print("Type: \(account.type)")
                                        print("Nickname: \(account.nickname)")
                                        print("Balance: \(account.balance)")
                                        print("-----")
                                    }
                                    // If you're updating UI elements, do it here
                                    // e.g., self.accounts = accounts
                                }
                            case .failure(let error):
                                // Handle the error
                                DispatchQueue.main.async {
                                    print("Error retrieving accounts: \(error.localizedDescription)")
                                    // Show an error message to the user or log the error
                                }
                            }
                        }
                    })
                }
                .padding(.horizontal, 15)
                .padding(.top, -100)
          
                Spacer()
            }
            
        }
        
       
    }
}

#Preview {
    AccountView(customer: Customer(_id: "66e613bc9683f20dd5189c26", first_name: "Alonso", last_name: "Huerta", address: Address(street_number: "333", street_name: "Street Name", city: "MTY", state: "NL", zip: "96400")))
}


