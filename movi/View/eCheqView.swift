//
//  eCheqView.swift
//  movi
//
//  Created by Alonso Huerta on 14/09/24.
//

import SwiftUI

struct Contact: Identifiable {
    let id = UUID()
    let name: String
    let emoji: String
    let color: Color
}

struct eCheqView: View {
    @State private var activeSheet: ActiveSheet?

    enum ActiveSheet: Identifiable {
        case send, receive, transaction

        var id: Int {
            hashValue
        }
    }

    let contacts: [Contact] = [
        Contact(name: "Valeria Pávan", emoji: "👧🏻", color: .cyan),
        Contact(name: "Rosa's Food Truck", emoji: "🚛", color: .blue),
        Contact(name: "Birria Taco Place", emoji: "🌮", color: .green),
        Contact(name: "Street Corn Cart", emoji: "🌽", color: .black),
        Contact(name: "Fresh Fruit at the Market", emoji: "🍎", color: .cyan),
        Contact(name: "Alonso Huerta", emoji: "🐛", color: .pink)
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "#f2f2f7")
                    .ignoresSafeArea()
                
                VStack {
                    GeometryReader { geometry in
                        VStack {
                            Spacer()
                            AppLogoHeader()
                            Spacer()
                            Text("MoBi ECheqs")
                                .font(.system(size: 30))
                                .multilineTextAlignment(.center)
                                .bold()
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height / 2 )
                        .background(randomDarkBlueGradient())
                    }
                    .frame(height: UIScreen.main.bounds.height / 3)
                    .padding(.bottom, -160)

                    List {
                        Section("Recently mobied") {
                            ForEach(contacts) { contact in
                                NavigationLink(destination: ContactView(contact: contact)) {
                                    HStack {
                                        ZStack {
                                            Circle()
                                                .fill(contact.color)
                                                .frame(width: 40, height: 40)
                                            
                                            Text(contact.emoji)
                                                .font(.system(size: 40 * 0.6))
                                        }
                                        Text(contact.name)
                                    }
                                }
                            }
                        }
                    }
                    .background(Color.clear)

                    HStack(alignment: .center) {
                        Spacer()
                        Button(action: {
                            activeSheet = .send
                        }, label: {
                            Label("Send", systemImage: "square.and.arrow.up")
                                .frame(minWidth: 150, minHeight: 50)
                        })
                        .background(Color(hex: "#0d507a"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()

                        Spacer()

                        Button(action: {
                            activeSheet = .receive
                        }, label: {
                            Label("Receive", systemImage: "square.and.arrow.down")
                                .frame(minWidth: 150, minHeight: 50)
                        })
                        .background(Color(hex: "#0d507a"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                        
                        Spacer()
                    }
                }
            }
        }
        .sheet(item: $activeSheet) { sheet in
            switch sheet {
            case .send:
                Text("Send")
            case .receive:
                Text("Receive")
            case .transaction:
                Text("Transaction View")
            }
        }
    }
}

#Preview {
    eCheqView()
}
