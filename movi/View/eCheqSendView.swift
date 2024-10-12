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
import LocalAuthentication

class NFCReader: NSObject, ObservableObject, NFCNDEFReaderSessionDelegate {
    @Published var scannedText: String = ""
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    var session: NFCNDEFReaderSession?
    
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
            // This method is called when the NFC session becomes active.
            // You can leave it empty if you don't need to handle this event.
            print("NFC session became active")
        }
    
    func beginScanning() {
            guard NFCNDEFReaderSession.readingAvailable else {
                alertMessage = "NFC is not available on this device."
                showAlert = true
                return
            }
            
            session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
            session?.alertMessage = "Hold your phone near recipient's."
            session?.begin()
    }
    
    // MARK: - NFCNDEFReaderSessionDelegate Methods
  
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
            DispatchQueue.main.async {
                self.alertMessage = error.localizedDescription
    //            self.showAlert = true
            }
        }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
            print("HERE")
            for message in messages {
                for record in message.records {
                    if let payload = String(data: record.payload, encoding: .utf8) {
                        DispatchQueue.main.async {
                            print("\(payload)")
                            self.scannedText = payload
                            self.alertMessage = "NFC Tag Detected: \(payload)"
    //                        self.showAlert = true
                        }
                    }
                }
            }
        }
}

struct eCheqSendView: View {
    @State var amount:String = ""
       var customer: Customer
       var accounts: [Account]
       @StateObject private var nfcReader = NFCReader()
       @State  var phoneNumber = ""
       @State private var showingAlert = false
       @State private var alertMessage = ""
       @Environment(\.dismiss) private var dismiss
       @State private var account: Account? = nil
    

    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    GeometryReader { geometry in
                        VStack (spacing: 0){
                            Spacer()
                            AppLogoHeader()
                                .padding(.top)
                            Spacer()
                            Text("MoBi Movement")
                                .font(.system(size: 30))
                                .multilineTextAlignment(.center)
                                .bold()
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height / 1.2 )
                        .background(randomRedGradient())
                    }
                    .frame(height: UIScreen.main.bounds.height / 3)
                    .padding(.top,-62)
                    
                    VStack(spacing: 20) {
                        HStack{
                            Text("Recipient Details")
                                .font(.headline)
                            Spacer()
                        }
                        HStack{
                            Section{
                                HStack {
                                    Image(systemName: "phone")
                                        .foregroundColor(.blue)
                                    TextField("Phone Number", text: $phoneNumber)
                                        .keyboardType(.phonePad)
                                    
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                            }
                            
                            Button(action: {
                                nfcReader.beginScanning()
                                
                            }) {
                                HStack {
                                    Image(systemName: "viewfinder")
                                    Text("Scan")
                                }
                            }
                            .padding()
                            .background(Color(hex: "#0d507a"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        
                        Section {
                            HStack{
                                Text("Transaction Details")
                                    .font(.headline)
                                Spacer()
                            }
                            HStack(spacing: 10) {
                                VStack {
                                    HStack {
                                        Image(systemName: "dollarsign.circle")
                                            .foregroundColor(.green)
                                        TextField("Amount", text: $amount)
                                            .keyboardType(.decimalPad)
                                    }
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                }
                                .frame(height: 50)  // Set a fixed height
                                
                                VStack {
                                    Picker("Account", selection: $account) {
                                        Text("None").tag(Optional<Account>(nil))
                                        
                                        ForEach(accounts, id: \._id) { account in
                                            Text(account.nickname).tag(account)
                                        }
                                    }
                                    .pickerStyle(MenuPickerStyle())
                                    .padding(.horizontal)
                                }
                                .frame(height: 50)  // Set the same fixed height
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                            }
                        }
                        
                        Button(action: sendECheq) {
                            Text("Send eCheq")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .background(Color(hex: "#EC0029"))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 2)

                        }
                    }
                    .padding()

                }
            }
            .onChange(of: nfcReader.scannedText, {
                phoneNumber = loadVCard(nfcReader.scannedText) ?? ""
            })
            .navigationBarHidden(true)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("eCheq Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }

        }
    }
    
    private func sendECheq() {
        guard let amount = Double(amount), amount > 0 else {
            alertMessage = "Please enter a valid amount."
            showingAlert = true
            return
        }
        
        guard isValidPhoneNumber(phoneNumber) else {
            alertMessage = "Please enter a valid phone number."
            showingAlert = true
            return
        }
        
        guard let account = account else {
            alertMessage = "Please enter a valid account"
            showingAlert = true
            return
        }
        
        createECheq(checkingAccountId: account._id, phoneNumber: phoneNumber, amount: amount) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let transferID):
                    alertMessage = "eCheq sent successfully! Transfer ID: \(transferID)"
                    showingAlert = true
                    dismiss()
                case .failure(let error):
                    alertMessage = "Failed to send eCheq: \(error.localizedDescription)"
                    showingAlert = true
                }
            }

        }
    }
    
    func loadVCard(_ vCardString: String) -> String? {
        guard let vCardData = vCardString.data(using: .utf8) else {
            print("Failed to convert VCard string to Data.")
            return nil
        }
        print(vCardData)
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
    
    func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneNumberRegex = "^[+]?[0-9]{10,15}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        return predicate.evaluate(with: phoneNumber)
    }
    
    func authenticate(completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?

        // Check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // It's possible, so go ahead and use it
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // Authentication has now completed
                if success {
                    // Authenticated successfully
                    completion(true)
                } else {
                    // There was a problem
                    completion(false)
                }
            }
        } else {
            // No biometrics available
            completion(false)
        }
    }
}

#Preview {
    eCheqSendView(customer: Customer(_id: "66e613bc9683f20dd5189c26", first_name: "Alonso", last_name: "Huerta", address: Address(street_number: "333", street_name: "Street Name", city: "MTY", state: "NL", zip: "96400")), accounts: [Account(_id: "66e62ed29683f20dd5189c6e", type: "balance", nickname: "Debit", rewards: 0, balance: 1000.0, account_number: nil, customer_id: "66e613bc9683f20dd5189c26")])
}
