//
//  HomeView.swift
//  Campus-Navigator
//
//  Created by Nadeesh Hirushan on 2025-02-23.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @State private var selectedCategory = "Labs"
    @State private var selectedTab = 0
    
    let categories = ["Labs", "Canteen", "Office", "Lecture Halls", "Library"]
    
    let labs = [
        LabItem(name: "Networking Lab", floor: "4th floor", image: "networking_lab"),
        LabItem(name: "iOS Lab", floor: "3rd floor", image: "ios_lab"),
        LabItem(name: "Web Design Lab", floor: "4th floor", image: "web_design_lab"),
        LabItem(name: "Research Lab", floor: "3rd floor", image: "research_lab")
    ]

    var body: some View {
        VStack {
            // Header Section
            HStack {
                VStack(alignment: .leading) {
                    Text("Welcome Hirushan!")
                        .font(.title2)
                        .fontWeight(.bold)

                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(.blue)
                        Text("Ground Floor")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                            .underline()
                    }
                }
                Spacer()
                
                // Profile Image
                Image("profile_pic") // Replace with actual image in Assets
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            }
            .padding(.horizontal)

            // Search Bar
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search by name, type...", text: $searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.5), lineWidth: 1))

                // Filter Button
                Button(action: {
                    // Filter action
                }) {
                    Image(systemName: "slider.horizontal.3")
                        .foregroundColor(.white)
                        .padding()
                        .background(Circle().fill(Color.blue))
                }
            }
            .padding(.horizontal)

            // Category Buttons
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(categories, id: \.self) { category in
                        Button(action: {
                            selectedCategory = category
                        }) {
                            Text(category)
                                .padding(.horizontal, 15)
                                .padding(.vertical, 8)
                                .background(selectedCategory == category ? Color.blue : Color.clear)
                                .foregroundColor(selectedCategory == category ? .white : .blue)
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule().stroke(Color.blue, lineWidth: 1)
                                )
                        }
                    }
                }
                .padding(.horizontal)
            }

            // Section Title
            HStack {
                Text("Labs")
                    .font(.title3)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.horizontal)

            // Grid of Labs
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                    ForEach(labs) { lab in
                        LabCardView(lab: lab)
                    }
                }
                .padding(.horizontal)
            }

            // Bottom Navigation Bar (Reusable)
            BottomNavigationBar(selectedTab: $selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

// MARK: - Lab Card View
struct LabCardView: View {
    let lab: LabItem

    var body: some View {
        VStack(alignment: .leading) {
            Image(lab.image) // Ensure images are added in Assets
                .resizable()
                .scaledToFill()
                .frame(height: 120)
                .cornerRadius(10)
                .clipped()

            Text(lab.name)
                .font(.headline)
                .foregroundColor(.black)

            Text(lab.floor)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

// MARK: - Lab Model
struct LabItem: Identifiable {
    let id = UUID()
    let name: String
    let floor: String
    let image: String
}
