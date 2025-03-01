//
//  SplashScreenView.swift
//  Campus-Navigator
//
//  Created by Nadeesh Hirushan on 2025-02-23.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    
    var body: some View {
        ZStack {
            // Background Color
            Color.blue
                .ignoresSafeArea()

            VStack {
                Spacer()

                // App Name with underline, perfectly centered
                VStack(spacing: 8) {
                    Text("Campus Navigator")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .overlay(
                            Rectangle()
                                .frame(height: 2)
                                .offset(y: 10) // Moves underline down
                                .foregroundColor(.white),
                            alignment: .bottom
                        )
                }
                .padding(.bottom, 20) // Space below text

                Spacer()
                
                // Tagline at Bottom
                Text("Find Exact Location of your choice")
                    .font(.footnote)
                    .foregroundColor(.white)
                    .padding(.bottom, 40)
            }
        }
        .onAppear {
            // Delayed Navigation to Login Screen
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isActive = true
            }
        }
        .fullScreenCover(isPresented: $isActive) {
            LoginView()
        }
    }
}
