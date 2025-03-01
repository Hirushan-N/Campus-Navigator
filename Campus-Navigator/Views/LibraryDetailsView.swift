//
//  LibraryDetailsView.swift
//  Campus-Navigator
//
//  Created by Nadeesh Hirushan on 2025-02-23.
//

import SwiftUI

struct LibraryDetailsView: View {
    let name: String
    let floor: String
    
    @State private var thumbsUpCount = 30
    @State private var thumbsDownCount = 2
    @State private var isThumbsUpSelected = false
    @State private var isThumbsDownSelected = false
    @State private var navigateToSeatReservation = false
    @State private var selectedTab = 0
    @State private var navigateToMap = false

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    
                    Image("library_image")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 250)
                        .cornerRadius(15)
                        .padding(.horizontal)

                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Location")
                                .font(.headline)
                                .bold()
                            Text(floor)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
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

                    NavigationLink(destination: NavigationMapView(), isActive: $navigateToMap) {
                        EmptyView()
                    }
                    .hidden()
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Type")
                            .font(.headline)
                            .bold()
                        Text("Study Area")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Operating Hours")
                            .font(.headline)
                            .bold()
                        
                        HStack {
                            Circle()
                                .frame(width: 6, height: 6)
                                .foregroundColor(.blue)
                            Text("Monday – Friday: ")
                                .fontWeight(.bold)
                            Text("8:00 AM – 8:00 PM")
                        }
                        
                        HStack {
                            Circle()
                                .frame(width: 6, height: 6)
                                .foregroundColor(.blue)
                            Text("Saturday – Sunday: ")
                                .fontWeight(.bold)
                            Text("9:00 AM – 5:00 PM")
                        }
                    }
                    .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 8) {
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
                    }
                    .padding(.horizontal)

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
                    .padding(.horizontal)
                }
            }

            Spacer()

            NavigationLink(destination: SeatReservationView(), isActive: $navigateToSeatReservation) {
                EmptyView()
            }
            .hidden()

            Button(action: {
                navigateToSeatReservation = true
            }) {
//                HStack {
//                    Text("Reserve Seat")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                    
//                    Image(systemName: "arrow.right.circle.fill")
//                        .foregroundColor(.white)
//                }
//                .frame(maxWidth: .infinity)
//                .padding()
//                .background(Color.blue)
//                .cornerRadius(10)
            }
            .padding(.horizontal)

            Spacer().frame(height: 15)

            BottomNavigationBar(selectedTab: $selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
