//
//  HomeView.swift
//  Campus-Navigator
//
//  Created by Nadeesh Hirushan on 2025-02-23.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @State private var selectedCategory = "Cafeterias"
    @State private var selectedTab = 0
    @State private var showFilterSheet = false
    
    let categories = ["Cafeterias", "Labs", "Lecture Halls", "Libraries", "Offices"]
    
    let categoryItems: [String: [Item]] = [
        "Cafeterias": [
            Item(name: "Main Cafeteria", floor: "Ground Floor", image: "main_cafeteria", isReservationEnabled: false),
            Item(name: "Student Café", floor: "2nd floor", image: "student_cafe", isReservationEnabled: false),
            Item(name: "Coffee Corner", floor: "1st floor", image: "coffee_corner", isReservationEnabled: false),
            Item(name: "Snack Bar", floor: "Ground Floor", image: "snack_bar", isReservationEnabled: false),
            Item(name: "Healthy Bites", floor: "1st floor", image: "healthy_bites", isReservationEnabled: false),
            Item(name: "Quick Meals", floor: "3rd floor", image: "quick_meals", isReservationEnabled: false),
        ],
        "Labs": [
            Item(name: "Networking Lab", floor: "4th floor", image: "networking_lab", isReservationEnabled: false),
            Item(name: "iOS Lab", floor: "3rd floor", image: "ios_lab", isReservationEnabled: true),
            Item(name: "Web Design Lab", floor: "4th floor", image: "web_design_lab", isReservationEnabled: false),
        ],
        "Lecture Halls": [
            Item(name: "Hall A", floor: "1st floor", image: "hall_a", isReservationEnabled: false),
            Item(name: "Hall B", floor: "2nd floor", image: "hall_b", isReservationEnabled: false),
            Item(name: "Hall C", floor: "3rd floor", image: "hall_c", isReservationEnabled: false),
        ],
        "Libraries": [
            Item(name: "Main Library", floor: "1st floor", image: "main_library", isReservationEnabled: false),
            Item(name: "Reading Room", floor: "2nd floor", image: "reading_room", isReservationEnabled: false),
        ],
        "Offices": [
            Item(name: "Admin Office", floor: "1st floor", image: "admin_office", isReservationEnabled: false),
            Item(name: "Student Affairs", floor: "2nd floor", image: "student_affairs", isReservationEnabled: false),
        ]
    ]
    
    var currentItems: [Item] {
        let items = categoryItems[selectedCategory] ?? []
        return items.filter { searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header Section
                HStack {
                    VStack(alignment: .leading) {
                        Text("Welcome, Hirushan!")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundColor(.blue)
                            Text("Ground Floor")
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }
                    }
                    
                    Spacer()
                    
                    Image("profile_pic")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                HStack(spacing: 10) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search by name...", text: $searchText)
                            .textFieldStyle(PlainTextFieldStyle())
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    // Filter Button
                    Button(action: { showFilterSheet.toggle() }) {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.white)
                            .frame(width: 45, height: 45)
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(categories, id: \.self) { category in
                            Button(action: {
                                selectedCategory = category
                            }) {
                                Text(category)
                                    .fontWeight(.medium)
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 8)
                                    .background(selectedCategory == category ? Color.blue : Color.clear)
                                    .foregroundColor(selectedCategory == category ? .white : .blue)
                                    .clipShape(Capsule())
                                    .overlay(
                                        Capsule().stroke(Color.blue, lineWidth: selectedCategory == category ? 0 : 1)
                                    )
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 5)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                        ForEach(currentItems) { item in
                            NavigationLink(destination: getCategoryDetailView(for: selectedCategory, item: item)) {
                                ItemCardView(item: item)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                }
                
                BottomNavigationBar(selectedTab: $selectedTab)
            }
            .background(Color(.systemBackground))
            .edgesIgnoringSafeArea(.bottom)
            .sheet(isPresented: $showFilterSheet) {
                FilterView()
            }
        }
    }

    @ViewBuilder
    func getCategoryDetailView(for category: String, item: Item) -> some View {
        switch category {
        case "Labs":
            LabDetailsView(name: item.name, floor: item.floor, isReservationEnabled:item.isReservationEnabled)
        case "Lecture Halls":
            LectureHallDetailsView(name: item.name, floor: item.floor)
        case "Libraries":
            LibraryDetailsView(name: item.name, floor: item.floor)
        case "Offices":
            OfficeDetailsView(name: item.name, floor: item.floor)
        default:
            CafeteriaDetailsView(name: item.name, floor: item.floor)
        }
    }
}

// MARK: - Item Card View
struct ItemCardView: View {
    let item: Item

    var body: some View {
        VStack(alignment: .leading) {
            Image(item.image)
                .resizable()
                .scaledToFill()
                .frame(height: 120)
                .cornerRadius(10)
                .clipped()
            
            Text(item.name)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(item.floor)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(color: Color.gray.opacity(0.15), radius: 3, x: 0, y: 2)
    }
}

// MARK: - Item Model
struct Item: Identifiable {
    let id = UUID()
    let name: String
    let floor: String
    let image: String
    let isReservationEnabled: Bool
}
