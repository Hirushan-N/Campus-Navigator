//
//  ProfileView.swift
//  Campus-Navigator
//
//  Created by Nadeesh Hirushan on 2025-02-28.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showLoginScreen = false // ✅ Full-screen navigation state

    let profileImage = "profile_pic"
    let userName = "Nadeesh Hirushan"
    let userBatch = "Batch 23.2P"

    var body: some View {
        VStack(spacing: 20) {
            // Drag Handle
            Capsule()
                .frame(width: 40, height: 5)
                .foregroundColor(Color.gray.opacity(0.4))
                .padding(.top, 10)

            // Profile Picture
            Image(profileImage)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.blue, lineWidth: 2))

            // User Info
            VStack(spacing: 5) {
                Text(userName)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(userBatch)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Divider()

            // Settings & Preferences
            VStack(spacing: 15) {
                ProfileOptionRow(icon: "gearshape.fill", title: "Settings")
                ProfileOptionRow(icon: "heart.fill", title: "Liked Items")
                ProfileOptionRow(icon: "person.2.fill", title: "Friend List")
                ProfileOptionRow(icon: "bell.fill", title: "Notifications")
            }
            .padding(.horizontal)

            Spacer()

            // Log Out Button
            Button(action: {
                logoutUser()
            }) {
                Text("Log Out")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)

            // ✅ Full-screen cover for LoginView
            .fullScreenCover(isPresented: $showLoginScreen) {
                LoginView()
            }

        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    // MARK: - Log Out Function
    private func logoutUser() {
        presentationMode.wrappedValue.dismiss() // Close Profile Sheet First
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            showLoginScreen = true // ✅ Show Login Screen as Full Screen
        }
    }
}


// MARK: - Profile Option Row
struct ProfileOptionRow: View {
    let icon: String
    let title: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 30)

            Text(title)
                .font(.headline)

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}
