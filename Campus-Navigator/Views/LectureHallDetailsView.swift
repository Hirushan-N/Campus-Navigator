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
    
    @State private var reviewThumbsUp = 30
    @State private var reviewThumbsDown = 2
    @State private var isReviewThumbsUpSelected = false
    @State private var isReviewThumbsDownSelected = false

    let weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

    let dayDetails: [String: (String, String, String)] = [
        "Mon": ("iOS Development", "23.2P Computing", "Dr. Thisara Weerasinghe"),
        "Tue": ("Mobile App Security", "23.1P Computing", "Dr. Amal Perera"),
        "Wed": ("Software Engineering", "22.2P Computing", "Dr. Nalin Karunarathna"),
        "Thu": ("Cloud Computing", "23.3P Computing", "Prof. Suranga Perera"),
        "Fri": ("Machine Learning", "23.2P Computing", "Dr. Chamara Silva"),
        "Sat": ("No Lecture", "", ""),
        "Sun": ("No Lecture", "", "")
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
                            
                            Text(selectedDay == "Sat" || selectedDay == "Sun" ? "NO CLASS" : "ONGOING")
                                .font(.caption)
                                .bold()
                                .padding(6)
                                .background(selectedDay == "Sat" || selectedDay == "Sun" ? Color.red : Color.green)
                                .cornerRadius(6)
                                .foregroundColor(.white)
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("**Module:** \(dayDetails[selectedDay]?.0 ?? "No Lecture")")
                            Text("**Batch:** \(dayDetails[selectedDay]?.1 ?? "-")")
                            Text("**Location:** \(floor)")
                            Text("**Lecturer:** \(dayDetails[selectedDay]?.2 ?? "-")")
                            
                            Text("**Operating Hours:**")
                            Text("08:30 AM - 04:00 PM")

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
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Image("profile_pic")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())

                                VStack(alignment: .leading) {
                                    Text("Binusha")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    Text("23.2P Computing - Student")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }

                                Spacer()
                                Text("1 month ago")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }

                            Text("I love how organized and comfortable the lecture hall is. There are plenty of charging outlets, and the Wi-Fi is strong. The seats are comfortable, and there’s enough space to take notes without feeling cramped.")
                                .font(.body)
                                .padding(.vertical, 5)

                            HStack {
                                Button(action: {
                                    if !isReviewThumbsUpSelected {
                                        reviewThumbsUp += 1
                                        isReviewThumbsUpSelected = true
                                        if isReviewThumbsDownSelected {
                                            reviewThumbsDown -= 1
                                            isReviewThumbsDownSelected = false
                                        }
                                    }
                                }) {
                                    HStack {
                                        Image(systemName: "hand.thumbsup.fill")
                                            .foregroundColor(isReviewThumbsUpSelected ? .blue : .gray)
                                        Text("\(reviewThumbsUp)")
                                    }
                                }

                                Button(action: {
                                    if !isReviewThumbsDownSelected {
                                        reviewThumbsDown += 1
                                        isReviewThumbsDownSelected = true
                                        if isReviewThumbsUpSelected {
                                            reviewThumbsUp -= 1
                                            isReviewThumbsUpSelected = false
                                        }
                                    }
                                }) {
                                    HStack {
                                        Image(systemName: "hand.thumbsdown.fill")
                                            .foregroundColor(isReviewThumbsDownSelected ? .red : .gray)
                                        Text("\(reviewThumbsDown)")
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
            
            BottomNavigationBar(selectedTab: $selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
