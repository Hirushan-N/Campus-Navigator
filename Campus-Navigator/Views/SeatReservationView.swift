//
//  SeatReservationView.swift
//  Campus-Navigator
//
//  Created by Nadeesh Hirushan on 2025-02-23.
//

import SwiftUI

struct SeatReservationView: View {
    @State private var selectedSeat: Seat?
    @State private var showSeatDetails = false
    @State private var remarks = ""
    @State private var contactNumber = ""
    
    let studentName = "Nadeesha Hirushan"
    let studentBatch = "23.2P"
    
    @State private var seats: [Seat] = [
        Seat(id: "PC-01", status: .available),
        Seat(id: "PC-02", status: .available),
        Seat(id: "PC-03", status: .available),
        Seat(id: "PC-04", status: .available),
        Seat(id: "PC-05", status: .available),
        Seat(id: "PC-06", status: .available),
        Seat(id: "PC-07", status: .booked, reservedBy: "John Doe", contact: "0771234567", remark: "For Project Work"),
        Seat(id: "PC-08", status: .available),
        Seat(id: "PC-09", status: .available),
        Seat(id: "PC-10", status: .available),
        Seat(id: "PC-11", status: .available),
        Seat(id: "PC-12", status: .available)
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Reserve My Seat")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding(.horizontal)
            
            HStack(spacing: 15) {
                StatusIndicator(text: "Available", color: .green)
                StatusIndicator(text: "Booked", color: .blue)
            }
            .padding(.top, 10)
            
            VStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(UIColor.systemGray6))
                    .overlay(
                        GridView(seats: $seats, selectedSeat: $selectedSeat, showSeatDetails: $showSeatDetails)
                            .padding()
                    )
                    .frame(height: 320)
            }
            .padding()
            
            Spacer()
            
            BottomNavigationBar(selectedTab: .constant(0))
        }
        .edgesIgnoringSafeArea(.bottom)
        .sheet(isPresented: $showSeatDetails) {
            SeatDetailsBottomSheet(
                seat: selectedSeat,
                remarks: $remarks,
                contactNumber: $contactNumber,
                seats: $seats,
                showSeatDetails: $showSeatDetails
            )
            .presentationDetents([.fraction(0.4)])
        }
    }
}

// MARK: - Seat Model
struct Seat: Identifiable {
    let id: String
    var status: SeatStatus
    var reservedBy: String?
    var contact: String?
    var remark: String?
    
    var idUUID: UUID { UUID() }
}

enum SeatStatus {
    case available, selected, booked
}

// MARK: - Status Indicator
struct StatusIndicator: View {
    let text: String
    let color: Color
    
    var body: some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: 12, height: 12)
            
            Text(text)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

// MARK: - GridView
struct GridView: View {
    @Binding var seats: [Seat]
    @Binding var selectedSeat: Seat?
    @Binding var showSeatDetails: Bool
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 4)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(seats.indices, id: \.self) { index in
                Button(action: {
                    selectedSeat = seats[index]
                    showSeatDetails = true
                }) {
                    Text(seats[index].id)
                        .fontWeight(.bold)
                        .frame(width: 80, height: 40)
                        .background(seats[index].status == .available ? Color.green : (seats[index].status == .selected ? Color.yellow : Color.blue))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                }
            }
        }
    }
}

// MARK: - Bottom Sheet for Seat Details
struct SeatDetailsBottomSheet: View {
    var seat: Seat?
    @Binding var remarks: String
    @Binding var contactNumber: String
    @Binding var seats: [Seat]
    @Binding var showSeatDetails: Bool

    var body: some View {
        VStack(spacing: 15) {
            Capsule()
                .frame(width: 50, height: 5)
                .foregroundColor(Color.gray.opacity(0.5))
                .padding(.top, 8)

            Text("Seat Information")
                .font(.headline)
            
            if let seat = seat {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Seat Number: **\(seat.id)**")
                    Text("Row & Column Position: **Row 2, Column 1**") // Static example
                    Text("Status: **\(seat.status == .available ? "Available" : "Booked")**")
                    
                    if seat.status == .available {
                        TextField("Enter Contact Number", text: $contactNumber)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.vertical, 5)
                        
                        TextField("Enter Remark", text: $remarks)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.vertical, 5)
                        
                        Button(action: {
                            bookSeat(seat: seat)
                            showSeatDetails = false
                        }) {
                            Text("Confirm Reservation")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    } else {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Reserved By: **\(seat.reservedBy ?? "Unknown")**")
                            Text("Contact: **\(seat.contact ?? "N/A")**")
                            Text("Remark: **\(seat.remark ?? "No Remark")**")
                        }
                        .padding(.top, 8)
                    }
                }
                .padding(.horizontal)
            }
            
            Spacer()
        }
        .padding(.bottom, 15)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(20)
        .shadow(radius: 5)
    }
    
    private func bookSeat(seat: Seat) {
        if let index = seats.firstIndex(where: { $0.id == seat.id }) {
            seats[index].status = .booked
            seats[index].reservedBy = "Nadeesh Hirushan"
            seats[index].contact = contactNumber
            seats[index].remark = remarks
        }
    }
}

