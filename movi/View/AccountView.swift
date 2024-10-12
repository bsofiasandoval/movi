//
//  AccountView.swift
//  movi
//
//  Created by Alonso Huerta on 14/09/24.
//

import SwiftUI

struct Transaction: Identifiable {
    let id = UUID()
    let date: Date
    let description: String
    let amount: Double
    let isDebit: Bool
}

struct AccountView: View {
    var customer: Customer
    var lastFour: String = "0773"
    
    @State var accounts: [Account]
    @State private var transactions: [Transaction] = [
        Transaction(date: Date().addingTimeInterval(-86400), description: "Grocery Store", amount: 45.67, isDebit: true),
        Transaction(date: Date().addingTimeInterval(-172800), description: "Deposit Deposit", amount: 2500.00, isDebit: false),
        Transaction(date: Date().addingTimeInterval(-259200), description: "Food", amount: 78.90, isDebit: true),
        Transaction(date: Date().addingTimeInterval(-345600), description: "Mobile Orders", amount: 123.45, isDebit: true),
        Transaction(date: Date().addingTimeInterval(-432000), description: "Utility Bill", amount: 89.99, isDebit: true)
    ]
    
    var body: some View {
        NavigationStack {
            VStack{
                GeometryReader { geometry in
                    VStack(spacing:0){
                        Spacer()
                        AppLogoHeader()
                        Spacer()
                        Text("Good Morning, \(customer.first_name)!")
                            .font(.system(size: 30))
                            .multilineTextAlignment(.center)
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height / 2 )
                    .background(randomRedGradient())
                }
                .frame(height: UIScreen.main.bounds.height / 3)
                .padding(.bottom, -153)
            }
            List {
                Section {
                    ForEach(accounts, id: \._id) { account in
                        VStack(alignment: .leading, spacing: 10) {
                            Text("TOTAL BALANCE (...\(lastFour))")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            HStack {
                                Text("$\(account.balance, specifier: "%.2f")")
                                    .font(.system(size: 30, weight: .bold))
                                Spacer()
                                Text("Available Balance")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 10)
                    }
                } header: {
                    Text("Accounts")
                }

                Section {
                    ForEach(transactions) { transaction in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(transaction.description)
                                    .font(.headline)
                                Text(transaction.date, style: .date)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Text(transaction.isDebit ? "-$\(transaction.amount, specifier: "%.2f")" : "+$\(transaction.amount, specifier: "%.2f")")
                                .foregroundColor(transaction.isDebit ? .red : .green)
                        }
                    }
                } header: {
                    Text("Recent Transactions")
                }
            }
            .listStyle(InsetGroupedListStyle())
        
        }
        .onAppear(perform: {
            getAccounts(customerId: customer._id) { result in
                switch result {
                case .success(let fetchedAccounts):
                    DispatchQueue.main.async {
                        self.accounts = fetchedAccounts
                    }
                case .failure(let error):
                    print("Error retrieving accounts: \(error.localizedDescription)")
                }
            }
        })
    }
}

#Preview {
    AccountView(customer: Customer(_id: "66e613bc9683f20dd5189c26", first_name: "Alonso", last_name: "Huerta", address: Address(street_number: "333", street_name: "Street Name", city: "MTY", state: "NL", zip: "96400")), accounts: [Account(_id: "66e62ed29683f20dd5189c6e", type: "balance", nickname: "Debit", rewards: 0, balance: 1000.0, account_number: nil, customer_id: "66e613bc9683f20dd5189c26")])
}
