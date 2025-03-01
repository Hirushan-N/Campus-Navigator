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
            Color.blue
                .ignoresSafeArea()

            VStack {
                Spacer()

                VStack(spacing: 8) {
                    Text("Campus Navigator")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .overlay(
                            Rectangle()
                                .frame(height: 2)
                                .offset(y: 10)
                                .foregroundColor(.white),
                            alignment: .bottom
                        )
                }
                .padding(.bottom, 20)

                Spacer()
                
                Text("Find Exact Location of your choice")
                    .font(.footnote)
                    .foregroundColor(.white)
                    .padding(.bottom, 40)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isActive = true
            }
        }
        .fullScreenCover(isPresented: $isActive) {
            LoginView()
        }
    }
}
