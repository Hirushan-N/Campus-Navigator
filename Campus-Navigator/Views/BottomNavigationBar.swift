//
//  BottomNavigationBar.swift
//  Campus-Navigator
//
//  Created by Nadeesh Hirushan on 2025-02-23.
//

import SwiftUI

struct BottomNavigationBar: View {
    @Binding var selectedTab: Int
    
    let icons = ["house.fill", "paperplane.fill", "speaker.wave.2.fill", "person.fill"]
    
    var body: some View {
        HStack {
            ForEach(0..<icons.count, id: \.self) { index in
                Spacer()
                BottomNavItem(icon: icons[index], isSelected: selectedTab == index)
                    .onTapGesture {
                        selectedTab = index
                    }
                Spacer()
            }
        }
        .padding()
        .background(Color.white.shadow(radius: 2))
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
