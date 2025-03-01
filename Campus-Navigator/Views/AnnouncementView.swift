//
//  Untitled.swift
//  Campus-Navigator
//
//  Created by Samod 037       on 2025-02-25.
//

import SwiftUI

struct AnnouncementView: View {
    let announcements: [String: [Announcement]] = [
        "Today": [
            Announcement(title: "2025 Career Fair", description: "Join this 1st Saturday in NIBM premises for valuable opportunities", time: "09:00 AM"),
            Announcement(title: "UI/UX Evening Lecture", description: "Students must attend this extra lecture starting from 5:00 PM to 8:00 PM", time: "05:00 PM")
        ],
        "Yesterday": [
            Announcement(title: "iOS App Development Hackathon", description: "Join us for an exciting Hackathon where innovation meets impact!", time: "10:00 AM"),
            Announcement(title: "AI for Developers Meetups", description: "Dive deep into AI development, machine learning, deep learning, and AI algorithms.", time: "08:00 AM")
        ],
        "Friday": [
            Announcement(title: "Azure AI Developer Hackathon", description: "Unleash the AI on the Azure cloud, gain intelligent applications on the Azure platform", time: "02:00 PM")
        ]
    ]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                Text("Announcement")
                    .font(.title2)
                    .bold()
                    .padding(.leading)
                    .padding(.top, -10)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(announcements.keys.sorted(by: >), id: \.self) { section in
                            Text(section)
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding(.leading)
                            
                            ForEach(announcements[section] ?? [], id: \.id) { announcement in
                                AnnouncementCard(announcement: announcement)
                            }
                        }
                    }
                }
                .padding(.top, 5)
            }
            .padding(.vertical)
        }
    }
}

struct Announcement: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let time: String
}

struct AnnouncementCard: View {
    let announcement: Announcement

    var body: some View {
        HStack {
            Image(systemName: "app.fill")
                .resizable()
                .frame(width: 28, height: 28)
                .foregroundColor(.blue)
                .padding(.leading, 10)

            VStack(alignment: .leading, spacing: 5) {
                Text(announcement.title)
                    .font(.headline)
                Text(announcement.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(announcement.time)
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.blue)
            }
            Spacer()
            
            Button(action: {
            }) {
                Image(systemName: "arrow.right.circle.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(15)
        .padding(.horizontal)
    }
}

struct AnnouncementView_Previews: PreviewProvider {
    static var previews: some View {
        AnnouncementView()
    }
}
