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
            List {
                Section("eCheq Actions") {
                    HStack(alignment: .center) {
                        Button(action: {
                            activeSheet = .send
                        }, label: { Label("Send", systemImage: "square.and.arrow.up") })
                        .buttonStyle(.borderless)

                        Spacer()
                        Divider()
                        Spacer()

                        Button(action: {
                            activeSheet = .receive
                        }, label: { Label("Receive", systemImage: "square.and.arrow.down") })
                        .buttonStyle(.borderless)
                    }
                    .padding()
                }
                Section("eCheqs") {

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
