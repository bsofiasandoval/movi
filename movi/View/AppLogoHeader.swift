//
//  AppLogoHeader.swift
//  movi
//
//  Created by Sofia Sandoval on 9/15/24.
//

import SwiftUI

struct AppLogoHeader: View {
    var body: some View {
        HStack {
            Spacer()
            Image("ClearAppIcon") // Make sure you have an image asset named "AppIcon"
                .resizable()
                .scaledToFit()
                .frame(height: 30) // Adjust this size as needed
            Spacer()
        }
        .padding(.top, 10) // Adjust top padding as needed
        .background(Color.clear) // This allows the background of the parent view to show through
    }
}

#Preview {
    AppLogoHeader()
        .background(Color.blue) // Just for preview purposes
}
