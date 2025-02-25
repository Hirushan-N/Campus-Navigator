//
//  LabDetailsView.swift
//  Campus-Navigator
//
//  Created by Nadeesh Hirushan on 2025-02-23.
//

import SwiftUI

struct LabDetailsView: View {
    let name: String
    let floor: String
    @State private var selectedTab = 0

    var body: some View {
        VStack {
            VStack(spacing: 10) {
                Text(name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Location: \(floor)")
                    .font(.title3)
            }
            .padding()
            
            Spacer()
            
            BottomNavigationBar(selectedTab: $selectedTab)
        }
        .navigationTitle("Lab Details")
        .edgesIgnoringSafeArea(.bottom)
    }
}
