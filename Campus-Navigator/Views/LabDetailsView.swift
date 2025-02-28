//
//  LabDetailsView.swift
//  Campus-Navigator
//
//  Created by Nadeesh Hirushan on 2025-02-23.
//

import SwiftUI

struct LabDetailsView: View {
    let name: String
    let floor: String
    let isReservationEnabled: Bool
    @State private var selectedTab = 0
    @State private var thumbsUpCount = 30
    @State private var thumbsDownCount = 2
    @State private var isThumbsUpSelected = false
    @State private var isThumbsDownSelected = false
    @State private var navigateToSeatReservation = false

    var body: some View {
        VStack {
            // Lab Image
            Image("web_design_lab") // Replace with actual lab image asset name
                .resizable()
                .scaledToFill()
                .frame(height: 250)
                .clipped()
            
            VStack(alignment: .leading, spacing: 12) {
                // Lab Name & Navigate Button
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
                
                // Location & Type
                VStack(alignment: .leading, spacing: 4) {
                    Text("**Location**")
                    Text("\(floor) Floor")
                        .font(.headline)

                    Text("**Type**")
                    Text("Lab Practical Session")
                        .font(.headline)
                }

                // Operating Hours
                VStack(alignment: .leading, spacing: 4) {
                    Text("**Operating Hours**")
                    HStack {
                        Text("• Monday – Friday:")
                        Text("**8:00 AM – 4:00 PM**")
                    }
                    HStack {
                        Text("• Saturday – Sunday:")
                        Text("**9:00 AM – 5:00 PM**")
                    }
                }

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
            }
            .padding()

            Spacer()

            NavigationLink(destination: SeatReservationView(), isActive: $navigateToSeatReservation) {
                EmptyView()
            }
            .hidden()

            // Reserve Seat Button
            Button(action: {
                if isReservationEnabled {
                    navigateToSeatReservation = true
                }
            }) {
                HStack {
                    Text("Reserve Seat")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Image(systemName: "arrow.right.circle.fill")
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(isReservationEnabled ? Color.blue : Color.gray)
                .cornerRadius(10)
            }
            .padding(.horizontal)
            .disabled(!isReservationEnabled)
            
            Spacer().frame(height: 15)
            // Bottom Navigation Bar
            BottomNavigationBar(selectedTab: $selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
