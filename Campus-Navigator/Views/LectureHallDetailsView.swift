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
    @State private var selectedDay = "Mon"
    @State private var thumbsUpCount = 30
    @State private var thumbsDownCount = 2
    @State private var isThumbsUpSelected = false
    @State private var isThumbsDownSelected = false

    @State private var showReviewSheet = false
    @State private var newReviewText = ""

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
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                }) {
                    VStack {
                        Image(systemName: "location.fill")
                            .font(.title)
                            .foregroundColor(.blue)
                        Text("Navigate")
                            .font(.caption)
                            .foregroundColor(.black)
                    }
                }
            }
            .padding(.horizontal)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    VStack(alignment: .leading, spacing: 8) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("**Operating Hours:** 08:30 AM - 04:00 PM")
                            Text("**Description:**")
                            Text("The \(name) is one of the largest and most frequently used lecture halls on campus. It is designed to provide students with a comfortable and well-equipped learning environment for lectures, presentations, and seminars.")
                        }
                        .font(.subheadline)
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
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

                                HStack {
                                    Button(action: { }) {
                                        HStack {
                                            Image(systemName: "hand.thumbsup.fill")
                                                .foregroundColor(.blue)
                                            Text("\(review.thumbsUp)")
                                        }
                                    }

                                    Button(action: { }) {
                                        HStack {
                                            Image(systemName: "hand.thumbsdown.fill")
                                                .foregroundColor(.red)
                                            Text("\(review.thumbsDown)")
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(10)
                            .padding(.horizontal)
                        }
                    }
                }
            }
            
            BottomNavigationBar(selectedTab: $selectedTab)
        }
        .sheet(isPresented: $showReviewSheet) {
            VStack(spacing: 20) {
                Text("Write a Review")
                    .font(.headline)
                    .padding(.top)

                TextEditor(text: $newReviewText)
                    .frame(height: 120)
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    .padding(.horizontal)

                HStack {
                    Button(action: {
                        showReviewSheet = false
                        newReviewText = ""
                    }) {
                        Text("Cancel")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }

                    Button(action: {
                        if !newReviewText.isEmpty {
                            reviews.append(Review(name: "Anonymous", batch: "N/A", timestamp: "Just now", content: newReviewText, profileImage: "profile_default", thumbsUp: 0, thumbsDown: 0))
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
            }
            .padding(.bottom, 20)
            .frame(height: UIScreen.main.bounds.height / 3)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 5)
        }


    }
}
