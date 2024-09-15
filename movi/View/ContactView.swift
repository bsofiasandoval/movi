//
//  ContactView.swift
//  movi
//
//  Created by Sofia Sandoval on 9/14/24.
//

import SwiftUI

struct ContactView: View {
    let contact: Contact

    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                Circle()
                    .fill(contact.color)
                    .frame(width: 100, height: 100)
                
                Text(contact.emoji)
                    .font(.system(size: 60))
            }
            
            Text(contact.name)
                .font(.title)
                .fontWeight(.bold)
            
         
            VStack(alignment: .leading, spacing: 10) {
                Text("Phone: +1 (555) 123-4567")
                Text("Email: \(contact.name.lowercased().replacingOccurrences(of: " ", with: "."))@example.com")
                Text("Address: 123 Main St, Anytown, USA")
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2.5)
            
            Spacer()
            
            Button(action: {
                print("Send money to \(contact.name)")
            }) {
                Text("Send Money")
                    .frame(minWidth: 200, minHeight: 50)
                    .background(Color(hex: "#0d507a"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Contact Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ContactView(contact: Contact(name: "Valeria Pávan", emoji: "👧🏻", color: .cyan))
}
