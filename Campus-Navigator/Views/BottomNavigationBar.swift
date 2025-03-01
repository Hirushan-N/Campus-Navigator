//
//  BottomNavigationBar.swift
//  Campus-Navigator
//
//  Created by Nadeesh Hirushan on 2025-02-23.
//

import SwiftUI

struct BottomNavigationBar: View {
    @Binding var selectedTab: Int
    @State private var navigateToHome = false
    @State private var navigateToMap = false
    @State private var navigateToAnnouncements = false
    @State private var showProfileSheet = false // ✅ State for profile sheet

    let icons = ["house.fill", "paperplane.fill", "speaker.wave.2.fill", "person.fill"]

    var body: some View {
        HStack {
            ForEach(0..<icons.count, id: \.self) { index in
                Spacer()
                BottomNavItem(icon: icons[index], isSelected: selectedTab == index)
                    .onTapGesture {
                        if index == 0 { navigateToHome = true }
                        if index == 1 { navigateToMap = true }
                        if index == 2 { navigateToAnnouncements = true }
                        if index == 3 { showProfileSheet = true } // ✅ Open profile view
                        selectedTab = index
                    }
                Spacer()
            }
        }
        .padding()
        .background(Color.white.shadow(radius: 2))
        .background(
            Group {
                NavigationLink(destination: HomeView(), isActive: $navigateToHome) {
                    EmptyView()
                }
                .hidden()

                NavigationLink(destination: NavigationMapView(), isActive: $navigateToMap) {
                    EmptyView()
                }
                .hidden()

                NavigationLink(destination: AnnouncementView(), isActive: $navigateToAnnouncements) {
                    EmptyView()
                }
                .hidden()
            }
        )
        .sheet(isPresented: $showProfileSheet) { // ✅ Show Profile Bottom Sheet
            ProfileView()
                .presentationDetents([.medium, .large]) // **iOS Standard**
        }
    }
}


// MARK: - Bottom Navigation Item
struct BottomNavItem: View {
    let icon: String
    let isSelected: Bool

    var body: some View {
        Image(systemName: icon)
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
            .foregroundColor(isSelected ? .blue : .gray)
            .padding(10)
            .background(isSelected ? Color.blue.opacity(0.2) : Color.clear)
            .clipShape(Circle())
    }
}
