//
//  ExploreView.swift
//  movi
//
//  Created by Sofia Sandoval on 9/14/24.
//

import SwiftUI

struct ExploreView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                GeometryReader { geometry in
                    VStack (spacing: 0){
                        AppLogoHeader()
                        Spacer()
                        Text("Explore your financial freedom")
                            .font(.system(size: 30))
                            .multilineTextAlignment(.center)
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height / 2 )
                    .background(randomRedGradient())
                }
                .frame(height: UIScreen.main.bounds.height / 3)
                
                VStack(spacing: 14) {
                    NavigationLink(destination: MicroCreditView()) {
                        HStack(alignment: .top) {
                            Image(systemName: "banknote")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                                .padding(.leading, 10)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Micro Credit")
                                    .font(.system(size: 23, weight: .bold))
                                    .foregroundColor(.white)
                                Text("See how much you're approved to borrow as a trusted MoBi Customer")
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.leading)
                                    .font(.body)
                            }
                            .padding(.leading, 10)
                            
                            Spacer()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 140)
                        .background(randomRedGradient())
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }

                    NavigationLink(destination: MicroSavingsView()) {
                        HStack(alignment: .top) {
                            Image(systemName: "cube.box.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                                .padding(.leading, 10)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Micro Savings")
                                    .font(.system(size: 23, weight: .bold))
                                    .foregroundColor(.white)
                                Text("Learn about what you can do to save money the easy way.")
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.leading)
                                    .font(.body)
                            }
                            .padding(.leading, 10)
                            
                            Spacer()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 140)
                        .background(randomRedGradient())
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }

                    NavigationLink(destination: MicroInsuranceView()) {
                        HStack(alignment: .top) {
                            Image(systemName: "shield.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                                .padding(.leading, 10)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Micro Insurance")
                                    .font(.system(size: 23, weight: .bold))
                                    .foregroundColor(.white)
                                Text("Explore insurance options for short or long-term earnings")
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.white)
                                    .font(.body)
                            }
                            .padding(.leading, 10)
                            
                            Spacer()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 140)
                        .background(randomRedGradient())
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                }
                .padding(.horizontal, 15)
                .padding(.top, -90)
                Spacer()
            }
        }
    }
}

// Helper gradient functio


func blueComplementaryColor() -> Color {
    // Calculate the complementary color (opposite on the color wheel)
    let complement = Color(
        hue: 0.08, // Approximately 30 degrees on the color wheel (180 degrees from blue)
        saturation: 0.8,
        brightness: 0.9
    )
    
    return complement
}


func randomRedGradient() -> LinearGradient {
    let baseColor = Color(hex: "#EC0029") // Custom hex initializer
    let lighterBlue = Color(
        red: 1, green: 0, blue: 0,  opacity: 0.4 // Lighter complementary blue
    )
    
    return LinearGradient(
        gradient: Gradient(colors: [baseColor, lighterBlue]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

 

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8 * 4) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


#Preview {
    ExploreView()
}
