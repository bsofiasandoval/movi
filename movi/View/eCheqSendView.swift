//
//  eCheqSendView.swift
//  movi
//
//  Created by Alonso Huerta on 14/09/24.
//

import Foundation
import CoreNFC
import Contacts
import ContactsUI
import SwiftUI

class NFCReader: NSObject, ObservableObject, NFCNDEFReaderSessionDelegate {
    @Published var scannedText: String = ""
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    var session: NFCNDEFReaderSession?
    
    func beginScanning() {
        guard NFCNDEFReaderSession.readingAvailable else {
            alertMessage = "NFC is not available on this device."
            showAlert = true
            return
        }
        
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session?.alertMessage = "Hold your iPhone near the NFC tag."
        session?.begin()
    }
    
    // MARK: - NFCNDEFReaderSessionDelegate Methods
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        DispatchQueue.main.async {
            self.alertMessage = error.localizedDescription
            self.showAlert = true
        }
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        for message in messages {
            for record in message.records {
                if let payload = String(data: record.payload, encoding: .utf8) {
                    DispatchQueue.main.async {
                        self.scannedText = payload
                        self.alertMessage = "NFC Tag Detected: \(payload)"
                        self.showAlert = true
                    }
                }
            }
        }
    }
}



struct eCheqSendView: View {
    @StateObject private var nfcReader = NFCReader()
    @State private var phoneNumber = ""
    @State private var amount = ""
    
    @Environment(\.dismiss) var dismiss
    
    var customer: Customer
    var accounts: [Account]
    @State private var account: Account = Account(_id: "66e62ed29683f20dd5189c6e", type: "balance", nickname: "Debit", rewards: 0, balance: 1000.0, account_number: nil, customer_id: "66e613bc9683f20dd5189c26")
    
    var body: some View {
        Form {
            TextField("PhoneNumber", text: $phoneNumber, prompt: Text("PhoneNUmber"))
            
            TextField("Amount", text: $amount, prompt: Text("Amount"))
                .keyboardType(.decimalPad)
            
            Picker("Account", selection: $account, content: {
                ForEach(accounts, id: \._id){
                    account in
                    Text(account.nickname).tag(account)
                }
            })
            
            Button(action: {
                nfcReader.beginScanning()
                phoneNumber = loadVCard(nfcReader.scannedText) ?? ""
                
            }) {
                Text("Scan VCard")
            }
            
            Button(action: {
                // Try to convert amount to Double
                guard let amount = Double(amount) else {
                    print("Invalid amount. Please enter a valid number.")
                    return
                }
                
                // Validate phone number (assuming a simple validation)
                guard isValidPhoneNumber(phoneNumber) else {
                    print("Invalid phone number. Please enter a valid phone number.")
                    return
                }
                
                // Check that the account is not nil
//                guard let account = self.account else {
//                    print("Account is missing.")
//                    return
//                }
                
                // Call the createECheq function
                createECheq(checkingAccountId: account._id, phoneNumber: phoneNumber, amount: amount) { result in
                    DispatchQueue.main.async { // Ensure UI updates happen on the main thread
                        switch result {
                        case .success(let transferID):
                            print("eCheq created with transfer ID: \(transferID)")
                            dismiss()
                            // You can display an alert or update the UI here to notify the user of success
                        case .failure(let error):
                            print("Failed to create eCheq: \(error.localizedDescription)")
                            // You can display an alert or update the UI here to notify the user of failure
                        }
                    }
                }
            }) {
                Text("Create")
            }
        }
        .alert(isPresented: $nfcReader.showAlert) {
            Alert(title: Text("NFC"), message: Text(nfcReader.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func loadVCard(_ vCardString: String) -> String? {
        guard let vCardData = vCardString.data(using: .utf8) else {
            print("Failed to convert VCard string to Data.")
            return nil
        }
        do {
            let contacts = try CNContactVCardSerialization.contacts(with: vCardData)
            if let contact = contacts.first {
                if let phone = contact.phoneNumbers.first {
                    return phone.value.stringValue
                }
                return nil
            }
        } catch {
            print("Failed to parse VCard data: \(error.localizedDescription)")
        }
        return nil
    }
    
    // Function to validate phone number (simple example)
    func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneNumberRegex = "^[+]?[0-9]{10,15}$" // A simple regex for validation
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        return predicate.evaluate(with: phoneNumber)
    }
}

#Preview {
    eCheqSendView(customer: Customer(_id: "66e613bc9683f20dd5189c26", first_name: "Alonso", last_name: "Huerta", address: Address(street_number: "333", street_name: "Street Name", city: "MTY", state: "NL", zip: "96400")), accounts: [Account(_id: "66e62ed29683f20dd5189c6e", type: "balance", nickname: "Debit", rewards: 0, balance: 1000.0, account_number: nil, customer_id: "66e613bc9683f20dd5189c26")])
}
