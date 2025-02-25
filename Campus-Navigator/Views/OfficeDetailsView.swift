//
//  OfficeDetailsView.swift
//  Campus-Navigator
//
//  Created by Nadeesh Hirushan on 2025-02-23.
//  Modified by Binusha Samod on 2025-02-25.
//

import SwiftUI

struct OfficeDetailsView: View {
    let name: String
    let floor: String
    @State private var selectedTab = 0
    @State private var selectedDay = "Mon"
    @State private var thumbsUpCount = 30
    @State private var thumbsDownCount = 2
    @State private var isThumbsUpSelected = false
    @State private var isThumbsDownSelected = false

    let weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

    let dayDetails: [String: (String, Bool)] = [
        "Mon": ("08:30 AM - 04:00 PM", true),
        "Tue": ("08:30 AM - 04:00 PM", true),
        "Wed": ("08:30 AM - 04:00 PM", true),
        "Thu": ("08:30 AM - 04:00 PM", true),
        "Fri": ("08:30 AM - 04:00 PM", true),
        "Sat": ("10:00 AM - 02:00 PM", true),
        "Sun": ("Closed", false)
    ]

    let services = [
        "Enrollment & Registration Support",
        "Student ID Issuance & Renewal",
        "Campus Event & Club Registration",
        "Scholarships & Financial Aid Guidance",
        "Student Complaints & Student Well-being Services"
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
                    // Navigate Action
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
            
            Spacer()
            Spacer()
            Spacer()

            
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

                Text(dayDetails[selectedDay]?.1 == true ? "OPEN" : "CLOSED")
                    .font(.caption)
                    .bold()
                    .padding(6)
                    .background(dayDetails[selectedDay]?.1 == true ? Color.green : Color.red)
                    .cornerRadius(6)
                    .foregroundColor(.white)
            }
            .padding(.horizontal)

            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    // Office Information Section
                    VStack(alignment: .leading, spacing: 8) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("**Operating Hours:**")
                            Text(dayDetails[selectedDay]?.0 ?? "Closed")

                            Text("**Location:**")
                            Text("\(floor)")

                            Text("**Services Offered:**")
                            ForEach(services, id: \.self) { service in
                                HStack {
                                    Image(systemName: "circle.fill")
                                        .resizable()
                                        .frame(width: 6, height: 6)
                                        .foregroundColor(.blue)
                                    Text(service)
                                }
                            }

                            Text("**Description:**")
                            Text("""
                            The Student Affairs Office is the central hub for student support services, providing assistance with various academic and non-academic needs. Whether you are a new student looking for guidance on campus life or a continuing student needing support with enrollment, financial aid, or student activities, this office is here to help.

                            The university has designed the Student Affairs Office to be a one-stop support center where students can get assistance with everything from course registration and student ID issuance to scholarship applications and extracurricular activities. The office also serves as a place where students can voice concerns, seek counseling, and get information about university policies and student rights.
                            """)
                        }
                        .font(.subheadline)
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
         
                }
            }

            // Bottom Navigation Bar
            BottomNavigationBar(selectedTab: $selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
