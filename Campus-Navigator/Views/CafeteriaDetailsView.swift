//
//  CafeteriaDetailsView.swift
//  Campus-Navigator
//
//  Created by Nadeesh Hirushan on 2025-02-23.
//  Modified by Binusha Samod on 2025-02-25.
//

import SwiftUI

struct CafeteriaDetailsView: View {
    let name: String
    let floor: String
    @State private var selectedTab = 0
    @State private var selectedDay = "Mon"
    @State private var thumbsUpCount = 30
    @State private var thumbsDownCount = 2
    @State private var isThumbsUpSelected = false
    @State private var isThumbsDownSelected = false
    @State private var cart: [UUID: Int] = [:]
    @State private var navigateToMap = false

    let weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

    let dayDetails: [String: (String, String)] = [
        "Mon": ("08:00 AM - 03:00 PM", "Grilled Sandwiches, Pasta, Fresh Juices"),
        "Tue": ("08:00 AM - 04:00 PM", "Chicken Rice, Smoothies"),
        "Wed": ("08:30 AM - 03:30 PM", "Burgers, Salads"),
        "Thu": ("08:00 AM - 02:30 PM", "Pizza, Fresh Juices"),
        "Fri": ("09:00 AM - 03:00 PM", "Pasta, Ice Cream"),
        "Sat": ("10:00 AM - 03:00 PM", "Rice & Curry, Beverages"),
        "Sun": ("Closed", "No Service")
    ]

    let dishes = [
        Dish(name: "Chicken Curry", price: "LKR 320", rating: 4.2, image: "d_1"),
        Dish(name: "Veggie Pasta", price: "LKR 280", rating: 4.5, image: "d_2"),
        Dish(name: "Mushroom Salad", price: "LKR 350", rating: 4.1, image: "d_3"),
        Dish(name: "Nachos", price: "LKR 300", rating: 4.3, image: "d_44"),
        Dish(name: "Grilled Sandwich", price: "LKR 290", rating: 4.4, image: "d_5")
    ]

    var body: some View {
        VStack {
            // Header Section
            HStack {
                Text(name)
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    navigateToMap = true // Trigger navigation
                }) {
                    VStack {
                        Image(systemName: "location.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding(.horizontal)
            
            NavigationLink(destination: NavigationMapView(), isActive: $navigateToMap) {
                EmptyView()
            }
            .hidden()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    // Cafeteria Information Section
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            ForEach(weekdays, id: \.self) { day in
                                Button(action: {
                                    selectedDay = day
                                }) {
                                    Text(day)
                                        .font(.caption)
                                        .padding(6)
                                        .background(selectedDay == day ? Color.blue : Color.gray.opacity(0.2))
                                        .cornerRadius(6)
                                        .foregroundColor(selectedDay == day ? .white : .black)
                                }
                            }
                            
                            Spacer()
                            
                            Text(selectedDay == "Sun" ? "CLOSED" : "OPEN")
                                .font(.caption)
                                .bold()
                                .padding(6)
                                .background(selectedDay == "Sun" ? Color.red : Color.green)
                                .cornerRadius(6)
                                .foregroundColor(.white)
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("**Operating Hours:**")
                            Text(dayDetails[selectedDay]?.0 ?? "Closed")

                            Text("**Popular Items:**")
                            Text(dayDetails[selectedDay]?.1 ?? "No Service")

                            Text("**Description:**")
                            Text("The \(name) offers a variety of fresh and affordable meals, snacks, and beverages for students and staff.")
                        }
                        .font(.subheadline)
                        .padding()
                        .background(Color(.systemGray6).opacity(0.1))
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    // Rating Section with Voting
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Low")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                        
                        HStack {
                            ProgressView(value: 0.34)
                                .progressViewStyle(LinearProgressViewStyle(tint: Color.green))
                                .frame(maxWidth: .infinity)
                            
                            Text("34%")
                                .font(.footnote)
                                .fontWeight(.bold)
                                .foregroundColor(.green)
                        }
                        
                        HStack {
                            Button(action: {
                                if !isThumbsUpSelected {
                                    thumbsUpCount += 1
                                    isThumbsUpSelected = true
                                    if isThumbsDownSelected {
                                        thumbsDownCount -= 1
                                        isThumbsDownSelected = false
                                    }
                                }
                            }) {
                                HStack {
                                    Image(systemName: "hand.thumbsup.fill")
                                        .foregroundColor(isThumbsUpSelected ? .blue : .gray)
                                    Text("\(thumbsUpCount)")
                                }
                            }

                            Button(action: {
                                if !isThumbsDownSelected {
                                    thumbsDownCount += 1
                                    isThumbsDownSelected = true
                                    if isThumbsUpSelected {
                                        thumbsUpCount -= 1
                                        isThumbsUpSelected = false
                                    }
                                }
                            }) {
                                HStack {
                                    Image(systemName: "hand.thumbsdown.fill")
                                        .foregroundColor(isThumbsDownSelected ? .red : .gray)
                                    Text("\(thumbsDownCount)")
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading) {
                        // Title and Cart Button in Same Line
                        HStack {
                            Text("Available Dishes")
                                .font(.title3)
                                .fontWeight(.bold)
                            
                            Spacer()

                            Button(action: {
                            }) {
                                Image(systemName: "cart.fill")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal)

                        // Grid of Available Dishes (Next Line)
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                            ForEach(dishes) { dish in
                                DishCard(dish: dish, cart: $cart)
                            }
                        }
                        .padding(.horizontal)
                    }

                }
            }
            
            // Bottom Navigation Bar
            BottomNavigationBar(selectedTab: $selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

// MARK: - Dish Model
struct Dish: Identifiable {
    let id = UUID()
    let name: String
    let price: String
    let rating: Double
    let image: String
}

// MARK: - Dish Card View
struct DishCard: View {
    let dish: Dish
    @Binding var cart: [UUID: Int]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(dish.image)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 100)
                .clipped()
                .cornerRadius(10)
            
            HStack {
                Text(dish.name)
                    .font(.headline)
                    .lineLimit(1)
                
                Spacer()
                
                HStack(spacing: 2) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(String(format: "%.1f", dish.rating))
                        .font(.caption)
                }
            }
            
            Spacer()
            
            Text(dish.price)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Spacer()
            
            HStack {
                Button(action: {
                    if cart[dish.id, default: 0] > 0 {
                        cart[dish.id, default: 0] -= 1
                    }
                }) {
                    Image(systemName: "minus.circle.fill").foregroundColor(.blue)
                }

                
                Text("\(cart[dish.id, default: 0])").font(.subheadline)
                
                Button(action: { cart[dish.id, default: 0] += 1 }) {
                    Image(systemName: "plus.circle.fill").foregroundColor(.blue)
                }
            }
            
            Spacer()
            
            Button(action: {
                UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
            }) {
                HStack {
                    Text("Add to Cart")
                        .font(.subheadline)
                        .bold()

                    Image(systemName: "arrow.right.circle.fill")
                        .font(.headline)
                }
                .frame(maxWidth: .infinity, minHeight: 36) // Reduced height
                .padding(.horizontal)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20) // Slightly adjusted for a more compact look
            }
            .shadow(radius: 3)
        }
        .padding()
        .frame(width: 160, height: 300)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.gray.opacity(0.15), radius: 3, x: 0, y: 2)
    }
}
