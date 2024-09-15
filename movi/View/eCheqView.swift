//
//  eCheqView.swift
//  movi
//
//  Created by Alonso Huerta on 14/09/24.
//

import SwiftUI
struct eCheqView: View {
    @State private var activeSheet: ActiveSheet?

    enum ActiveSheet: Identifiable {
        case send, receive, transaction

        var id: Int {
            hashValue
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "#f2f2f7")
                    .ignoresSafeArea()
                
                VStack {
                    GeometryReader { geometry in
                        VStack {
                            Spacer()
                            Text("MoBi ECheqs")
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
                    .padding(.bottom, -160)

                    List {
                        Section("eCheqs") {
                            Spacer().frame(height: 100) // Adding more space for layout purposes
                        }
                    }
                    .listStyle(PlainListStyle())
                    .background(Color.clear)

                    HStack(alignment: .center) {
                        Spacer()
                        Button(action: {
                            activeSheet = .send
                        }, label: {
                            Label("Send", systemImage: "square.and.arrow.up")
                                .frame(minWidth: 150, minHeight: 50) // Set button size
                        })
                        .background(Color(hex: "#0d507a")) // Main blue color
                        .foregroundColor(.white) // White foreground
                        .cornerRadius(10)
                        .padding()

                        Spacer()

                        Button(action: {
                            activeSheet = .receive
                        }, label: {
                            Label("Receive", systemImage: "square.and.arrow.down")
                                .frame(minWidth: 150, minHeight: 50) // Set button size
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
