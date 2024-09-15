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
                        ContentView()
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
