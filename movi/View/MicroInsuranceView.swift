//
//  MicroInsuranceView.swift
//  movi
//
//  Created by Sofia Sandoval on 9/14/24.
//

import SwiftUI

struct MicroInsuranceView: View {
    @State private var selectedPlan: InsurancePlan?
    @Environment(\.presentationMode) var presentationMode
    
    enum InsurancePlan: String, CaseIterable, Identifiable {
        case basic = "Basic"
        case standard = "Standard"
        case premium = "Premium"
        
        var id: String { self.rawValue }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "#f2f2f7").edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    GeometryReader { geometry in
                        VStack(spacing:0) {
                            Spacer()
                            AppLogoHeader()
                            Spacer()
                            Text("Micro Insurance")
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
                            insurancePlansView
                            coverageDetailsView
                            benefitsView
                            getQuoteButton
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
    
    private var headerView: some View {
        VStack(spacing: 10) {
            Image(systemName: "shield")
                .resizable()
                .scaledToFit()
                .frame(height: 60)
                .foregroundColor(.white)
            Text("MoBi Micro Insurance")
                .font(.title)
                .fontWeight(.bold)
            Text("Protect your future, one step at a time")
                .font(.subheadline)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(randomRedGradient())
        .foregroundColor(.white)
        .cornerRadius(15)
    }
    
    private var insurancePlansView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Choose Your Plan")
                .font(.headline)
            Picker("Insurance Plan", selection: $selectedPlan) {
                ForEach(InsurancePlan.allCases) { plan in
                    Text(plan.rawValue).tag(Optional(plan))
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
    }
    
    private var coverageDetailsView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Coverage Details")
                .font(.headline)
            if let plan = selectedPlan {
                switch plan {
                case .basic:
                    Text("Basic coverage for essential needs")
                case .standard:
                    Text("Standard coverage for broader protection")
                case .premium:
                    Text("Premium coverage for comprehensive protection")
                }
            } else {
                Text("Select a plan to see coverage details")
            }
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
            BenefitRow(icon: "checkmark.shield", text: "Affordable premiums")
            BenefitRow(icon: "doc.text", text: "Easy claim process")
            BenefitRow(icon: "person.2", text: "Family coverage options")
        }
        .frame(width: 335)
        .padding()
        .background(Color.white)
        .cornerRadius(15)
    }
    
    private var getQuoteButton: some View {
        Button(action: {
            // Handle get quote action
        }) {
            Text("Get a Quote")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(hex: "#0d507a"))
                .cornerRadius(10)
        }
    }
}

struct BenefitRow: View {
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
        MicroInsuranceView()
    }
}
