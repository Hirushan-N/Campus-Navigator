//
//  NavigationMapView.swift
//  Campus-Navigator
//
//  Created by Nadeesh Hirushan on 2025-02-27.
//

import SwiftUI

struct NavigationMapView: View {
    @State private var selectedTab = 1 
    
    var body: some View {
        VStack {
            // Map Image (Placeholder for real map)
            Image("map_placeholder")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: .infinity)
                .overlay(
                    VStack {
                        // Search Bar
                        HStack {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                TextField("Search by name, type...", text: .constant(""))
                                    .textFieldStyle(PlainTextFieldStyle())
                            }
                            .padding()
                            .frame(height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color.white)
                                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                        }
                        .padding(.horizontal)

                        Spacer()
                        
                        // Location Info Card
                        HStack {
                            VStack(alignment: .leading) {
                                Text("**iOS Lab**")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Text("2 min (50 m)")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }
                            Spacer()
                            Button(action: {
                                // Navigate action
                            }) {
                                Image(systemName: "paperplane.fill")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Circle().fill(Color.blue))
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white).shadow(radius: 5))
                        .padding(.horizontal)

                    }
                    .padding(.top, 10),
                    alignment: .top
                )

        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
