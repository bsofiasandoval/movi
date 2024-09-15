//
//  MicroSavingsView.swift
//  movi
//
//  Created by Sofia Sandoval on 9/14/24.
//

import SwiftUI

struct MicroSavingsView: View {
    @State private var currentSavings: Double = 1500
    @State private var savingsGoal: Double = 5000
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "#f2f2f7").edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    GeometryReader { geometry in
                        VStack(spacing:0){
                            Spacer()
                            AppLogoHeader()
                            Spacer()
                            Text("Micro Savings")
                                .font(.system(size: 30))
                                .multilineTextAlignment(.center)
                                .bold()
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height / 1.2)
                        .background(randomDarkBlueGradient())
                    }
                    .frame(height: UIScreen.main.bounds.height / 3)
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            savingsProgressView
                            savingsTipsView
                            goalSettingView
                            startSavingButton
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
        .background(Color(hex: "#f2f2f7"))
    }
    

    private var savingsProgressView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Your Savings Progress")
                .font(.headline)
            ProgressView(value: currentSavings, total: savingsGoal)
                .accentColor(Color(hex: "#0d507a"))
            HStack {
                Text("$\(currentSavings, specifier: "%.2f")")
                Spacer()
                Text("$\(savingsGoal, specifier: "%.2f")")
            }
            .font(.caption)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
    }
    
    private var savingsTipsView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Savings Tips")
                .font(.headline)
            TipRow(icon: "dollarsign.circle", text: "Set aside a portion of each paycheck")
            TipRow(icon: "cart", text: "Cut unnecessary expenses")
            TipRow(icon: "chart.line.uptrend.xyaxis", text: "Increase your savings over time")
        }
        .padding()
        .frame(width: 365)
        .background(Color.white)
        .cornerRadius(15)
    }
    
    private var goalSettingView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Set a Savings Goal")
                .font(.headline)
            HStack {
                Text("$")
                TextField("Enter your goal", value: $savingsGoal, formatter: NumberFormatter())
                    .keyboardType(.decimalPad)
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
    }
    
    private var startSavingButton: some View {
        Button(action: {
            // Handle start saving action
        }) {
            Text("Start Saving")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(hex: "#0d507a"))
                .cornerRadius(10)
        }
    }
}

struct TipRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(Color(hex: "#0d507a"))
            Text(text)
            Spacer()
        }
    }
}

#Preview {
    NavigationView {
        MicroSavingsView()
    }
}
