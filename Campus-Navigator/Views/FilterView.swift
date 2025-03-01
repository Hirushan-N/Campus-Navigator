//
//  FilterView.swift
//  Campus-Navigator
//
//  Created by Nadeesh Hirushan on 2025-02-23.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.presentationMode) var presentationMode 
    @State private var selectedFloor = "All Floors"
    @State private var showAvailableOnly = false

    let floors = ["All Floors", "Ground Floor", "1st Floor", "2nd Floor", "3rd Floor", "4th Floor"]

    var body: some View {
        VStack(spacing: 20) {
            Text("Filter Options")
                .font(.title2)
                .fontWeight(.bold)

            VStack(alignment: .leading) {
                Text("Select Floor")
                    .font(.headline)
                Picker("Floor", selection: $selectedFloor) {
                    ForEach(floors, id: \.self) { floor in
                        Text(floor)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            .padding()

            Toggle("Show Available Only", isOn: $showAvailableOnly)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
                .padding(.horizontal)

            Spacer()

            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Apply Filters")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .font(.headline)
                    .cornerRadius(15)
            }
            .padding(.horizontal)
        }
        .padding(.top, 20)
    }
}
