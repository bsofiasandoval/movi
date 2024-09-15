//
//  AccountView.swift
//  movi
//
//  Created by Alonso Huerta on 14/09/24.
//

import SwiftUI

struct AccountView: View {
    var userName: String = "User"
    var lastFour: String = "0773"
    var currentBalance: Double = 150
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                        Text("Good Morning, \(userName)!")
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
                                            Text(currentBalance, format: .number.rounded(increment: 0.01))
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
                .padding(.horizontal, 15)
                .padding(.top, -100)
          
                Spacer()
            }
            
        }
        
       
    }
}

#Preview {
    AccountView()
}


