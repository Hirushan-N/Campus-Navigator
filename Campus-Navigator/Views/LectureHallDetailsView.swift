//
//  LectureHallDetailsView.swift
//  Campus-Navigator
//
//  Created by Nadeesh Hirushan on 2025-02-23.
//

import SwiftUI

struct LectureHallDetailsView: View {
    let name: String
    let floor: String
    @State private var selectedTab = 0
    @State private var showReviewSheet = false
    @State private var newReviewText = ""
    @State private var navigateToMap = false

    struct Review: Identifiable {
        let id = UUID()
        let name: String
        let batch: String
        let timestamp: String
        let content: String
        let profileImage: String
        var thumbsUp: Int
        var thumbsDown: Int
    }

    @State private var reviews: [Review] = [
        Review(name: "Binusha", batch: "23.2P", timestamp: "1 month ago", content: "I love how organized and comfortable the lecture hall is. There are plenty of charging outlets, and the Wi-Fi is strong. The seats are comfortable, and there’s enough space to take notes without feeling cramped.", profileImage: "profile_binusha", thumbsUp: 30, thumbsDown: 2),
        Review(name: "Kasun", batch: "23.1P", timestamp: "2 weeks ago", content: "Projector needs an upgrade, it flickers sometimes. Other than that, the hall is quite good.", profileImage: "profile_kasun", thumbsUp: 22, thumbsDown: 5),
        Review(name: "Ayesha", batch: "22.2P", timestamp: "3 days ago", content: "Good seating arrangement, but the AC is way too cold sometimes.", profileImage: "profile_ayesha", thumbsUp: 18, thumbsDown: 8),
        Review(name: "Nuwan", batch: "23.3P", timestamp: "1 week ago", content: "Spacious hall, comfortable chairs, and good audio system. Really great experience overall!", profileImage: "profile_nuwan", thumbsUp: 25, thumbsDown: 3)
    ]

    var body: some View {
        VStack {
            HStack {
                Text(name)
                    .font(.title2)
                    .fontWeight(.bold)

                Spacer()

                Button(action: {
                    navigateToMap = true 
                }) {
                    VStack {
                        Image(systemName: "location.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            NavigationLink(destination: NavigationMapView(), isActive: $navigateToMap) {
                EmptyView()
            }
            .hidden()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("**Operating Hours:** 08:30 AM - 04:00 PM")
                            .font(.subheadline)
                            .foregroundColor(.black)

                        Text("**Description:**")
                        Text("The \(name) is one of the largest and most frequently used lecture halls on campus. It is designed to provide students with a comfortable and well-equipped learning environment for lectures, presentations, and seminars.")
                            .font(.subheadline)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)

                    VStack(alignment: .leading) {
                        HStack {
                            Text("Student Reviews")
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.horizontal)

                            Spacer()

                            Button(action: {
                                showReviewSheet = true
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                            }
                        }

                        ForEach(reviews) { review in
                            ReviewCard(review: review)
                        }
                    }
                }
            }

            BottomNavigationBar(selectedTab: $selectedTab)
        }
        .sheet(isPresented: $showReviewSheet) {
            ReviewInputSheet(showReviewSheet: $showReviewSheet, newReviewText: $newReviewText, reviews: $reviews)
        }
    }
}

struct ReviewCard: View {
    let review: LectureHallDetailsView.Review

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(review.profileImage)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())

                VStack(alignment: .leading) {
                    Text(review.name)
                        .font(.headline)
                        .fontWeight(.bold)
                    Text("\(review.batch) - Student")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                Spacer()
                Text(review.timestamp)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Text(review.content)
                .font(.body)
                .padding(.vertical, 5)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

struct ReviewInputSheet: View {
    @Binding var showReviewSheet: Bool
    @Binding var newReviewText: String
    @Binding var reviews: [LectureHallDetailsView.Review]

    var body: some View {
        VStack {
            Capsule()
                .frame(width: 50, height: 5)
                .foregroundColor(Color(.systemGray3))
                .padding(.top, 10)

            Text("Write a Review")
                .font(.headline)
                .padding(.top, 5)

            TextEditor(text: $newReviewText)
                .frame(height: 120)
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5), lineWidth: 1))
                .padding(.horizontal)

            HStack {
                Button(action: {
                    showReviewSheet = false
                    newReviewText = ""
                }) {
                    Text("Cancel")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray5))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }

                Button(action: {
                    if !newReviewText.isEmpty {
                        reviews.append(LectureHallDetailsView.Review(
                            name: "Anonymous",
                            batch: "N/A",
                            timestamp: "Just now",
                            content: newReviewText,
                            profileImage: "profile_default",
                            thumbsUp: 0,
                            thumbsDown: 0
                        ))
                        newReviewText = ""
                        showReviewSheet = false
                    }
                }) {
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .frame(height: UIScreen.main.bounds.height * 0.35)
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .shadow(radius: 10)
        .edgesIgnoringSafeArea(.bottom)
    }
}
