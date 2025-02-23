//
//  HomeView.swift
//  Campus-Navigator
//
//  Created by Nadeesh Hirushan on 2025-02-23.
//

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
    
    let categories = ["Cafeterias", "Labs", "Lecture Halls", "Libraries", "Offices"]
    
    let cafeterias = [
        Item(name: "Main Cafeteria", floor: "Ground Floor", image: "main_cafeteria"),
        Item(name: "Student Café", floor: "2nd floor", image: "student_cafe"),
        Item(name: "Coffee Corner", floor: "1st floor", image: "coffee_corner"),
        Item(name: "Snack Bar", floor: "Ground Floor", image: "snack_bar"),
        Item(name: "Healthy Bites", floor: "1st floor", image: "healthy_bites"),
        Item(name: "Quick Meals", floor: "3rd floor", image: "quick_meals")
    ]
    
    let labs = [
        Item(name: "Networking Lab", floor: "4th floor", image: "networking_lab"),
        Item(name: "iOS Lab", floor: "3rd floor", image: "ios_lab"),
        Item(name: "Web Design Lab", floor: "4th floor", image: "web_design_lab"),
        Item(name: "Research Lab", floor: "3rd floor", image: "research_lab"),
        Item(name: "AI Lab", floor: "5th floor", image: "ai_lab"),
        Item(name: "Cybersecurity Lab", floor: "2nd floor", image: "cybersecurity_lab"),
        Item(name: "Robotics Lab", floor: "1st floor", image: "robotics_lab")
    ]
    
    let lectureHalls = [
        Item(name: "Hall A", floor: "1st floor", image: "hall_a"),
        Item(name: "Hall B", floor: "2nd floor", image: "hall_b"),
        Item(name: "Hall C", floor: "3rd floor", image: "hall_c"),
        Item(name: "Main Auditorium", floor: "Ground Floor", image: "auditorium"),
        Item(name: "Lecture Hall D", floor: "4th floor", image: "lecture_hall_d"),
        Item(name: "Lecture Hall E", floor: "5th floor", image: "lecture_hall_e"),
        Item(name: "Seminar Room", floor: "6th floor", image: "seminar_room")
    ]
    
    let libraries = [
        Item(name: "Main Library", floor: "1st floor", image: "main_library"),
        Item(name: "Reading Room", floor: "2nd floor", image: "reading_room"),
        Item(name: "Reference Section", floor: "3rd floor", image: "reference_section"),
        Item(name: "Study Lounge", floor: "Ground Floor", image: "study_lounge"),
        Item(name: "Digital Library", floor: "5th floor", image: "digital_library"),
        Item(name: "Historical Archives", floor: "3rd floor", image: "historical_archives")
    ]
    
    let offices = [
        Item(name: "Admin Office", floor: "1st floor", image: "admin_office"),
        Item(name: "Student Affairs", floor: "2nd floor", image: "student_affairs"),
        Item(name: "Finance Office", floor: "3rd floor", image: "finance_office"),
        Item(name: "IT Support", floor: "Ground Floor", image: "it_support"),
        Item(name: "Human Resources", floor: "2nd floor", image: "hr_office"),
        Item(name: "Admissions Office", floor: "1st floor", image: "admissions_office"),
        Item(name: "Registrar’s Office", floor: "3rd floor", image: "registrar_office")
    ]

    var currentItems: [Item] {
        let items = getCategoryItems(for: selectedCategory)
        return items.filter { searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    func getCategoryItems(for category: String) -> [Item] {
        switch category {
        case "Labs":
            return labs
        case "Lecture Halls":
            return lectureHalls
        case "Libraries":
            return libraries
        case "Offices":
            return offices
        default:
            return cafeterias
        }
    }

    var body: some View {
        NavigationView {
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
                    Image("profile_pic")
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
                    Text(selectedCategory)
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal)

                // Grid of Items (Navigating to Respective Views)
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                        ForEach(currentItems) { item in
                            NavigationLink(destination: getCategoryDetailView(for: selectedCategory, item: item)) {
                                ItemCardView(item: item)
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                // Bottom Navigation Bar
                BottomNavigationBar(selectedTab: $selectedTab)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }

    // Function to return the correct detail view for each category
    @ViewBuilder
    func getCategoryDetailView(for category: String, item: Item) -> some View {
        switch category {
        case "Labs":
            LabDetailsView(name: item.name, floor: item.floor)
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
            Image(item.image) // Ensure images are added in Assets
                .resizable()
                .scaledToFill()
                .frame(height: 120)
                .cornerRadius(10)
                .clipped()

            Text(item.name)
                .font(.headline)
                .foregroundColor(.black)

            Text(item.floor)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

// MARK: - Item Model
struct Item: Identifiable {
    let id = UUID()
    let name: String
    let floor: String
    let image: String
}
