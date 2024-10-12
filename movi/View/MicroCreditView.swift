//
//  MicroCreditView.swift
//  movi
//
//  Created by Sofia Sandoval on 9/14/24.
//

import SwiftUI

struct MicroCreditView: View {
    @State private var usage: Double = 50
    @State private var approvedAmount: Double = 5000
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "#f2f2f7").edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    GeometryReader { geometry in
                        VStack(spacing: 0) {
                            
                            Spacer()
                            AppLogoHeader()
                            Spacer()
                            Text("Micro Credit")
                                .font(.system(size: 30))
                                .multilineTextAlignment(.center)
                                .bold()
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height / 1.2)
                        .background(randomRedGradient())
                    }
                    .frame(height: UIScreen.main.bounds.height / 3)
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            usedMoneyView
                            approvedAmountView
                            benefitsView
                            applyButton
                        }
                        .padding(.horizontal)
                       
                    }
                    .padding(.top, -20) // Reduce space between header and ScrollView
                }
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
    
    private var usedMoneyView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Usage")
                .font(.headline)
            Text("$\(usage, specifier: "%.2f")")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("For this period before cutoff date")
                .font(.caption)
                .foregroundColor(.secondary)
                
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(15)
    }
    
    private var approvedAmountView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Approved Amount")
                .font(.headline)
            Text("$\(approvedAmount, specifier: "%.2f")")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("Based on your credit score and history")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(15)
    }
    
    private var benefitsView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Benefits")
                .font(.headline)
            BenefitRow(icon: "bolt", text: "Quick approval process")
            BenefitRow(icon: "percent", text: "Competitive interest rates")
            BenefitRow(icon: "calendar", text: "Flexible repayment terms")
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(15)
    }
    
    private var applyButton: some View {
        Button(action: {
            // Handle apply action
        }) {
            Text("Apply Now")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(hex: "#EC0029"))
                .cornerRadius(10)
        }
    }
}

#Preview {
    MicroCreditView()
}
