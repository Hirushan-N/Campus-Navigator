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
        VStack {
            // Header
            HStack {
                
                Text("Reserve My Seat")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding(.horizontal)
            
            // Seat Status Legend
            HStack {
                StatusIndicator(text: "Available", color: .green)
                StatusIndicator(text: "Selected", color: .yellow)
                StatusIndicator(text: "Booked", color: .blue)
            }
            .padding(.top, 10)
            
            // Seat Grid
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.blue.opacity(0.1))
                    .overlay(
                        GridView(seats: $seats, selectedSeat: $selectedSeat, showSeatDetails: $showSeatDetails)
                            .padding()
                    )
                    .frame(height: 300)
            }
            .padding()
            
            Spacer()
            
            // Bottom Navigation Bar
            BottomNavigationBar(selectedTab: .constant(0))
        }
        .edgesIgnoringSafeArea(.bottom)
        .sheet(isPresented: $showSeatDetails) {
            SeatDetailsBottomSheet(
                seat: selectedSeat,
                remarks: $remarks,
                contactNumber: $contactNumber,
                seats: $seats
            )
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
            Text(text)
                .font(.footnote)
                .padding(8)
                .background(color.opacity(0.2))
                .cornerRadius(8)
        }
    }
}

// MARK: - GridView
struct GridView: View {
    @Binding var seats: [Seat]
    @Binding var selectedSeat: Seat?
    @Binding var showSeatDetails: Bool
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(seats.indices, id: \.self) { index in
                Button(action: {
                    selectedSeat = seats[index]
                    showSeatDetails = true
                }) {
                    Text(seats[index].id)
                        .fontWeight(.bold)
                        .padding()
                        .frame(width: 80, height: 40)
                        .background(seats[index].status == .available ? Color.green : (seats[index].status == .selected ? Color.yellow : Color.blue))
                        .foregroundColor(.white)
                        .cornerRadius(8)
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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Seat Information")
                .font(.headline)
            
            if let seat = seat {
                Text("Selected Seat Number: **\(seat.id)**")
                Text("Row & Column Position: **Row 2, Column 1**") // Static example
                Text("Booking Status: **\(seat.status == .available ? "Available" : "Booked")**")
                
                if seat.status == .available {
                    TextField("Enter Contact Number", text: $contactNumber)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    
                    TextField("Enter Remark", text: $remarks)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    
                    Button(action: {
                        bookSeat(seat: seat)
                    }) {
                        HStack {
                            Text("Confirm Reservation")
                                .font(.headline)
                            Image(systemName: "checkmark.circle.fill")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                } else {
                    Text("Reserved By: **\(seat.reservedBy ?? "Unknown")**")
                    Text("Contact: **\(seat.contact ?? "N/A")**")
                    Text("Remark: **\(seat.remark ?? "No Remark")**")
                }
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
    }
    
    private func bookSeat(seat: Seat) {
        if let index = seats.firstIndex(where: { $0.id == seat.id }) {
            seats[index].status = .booked
            seats[index].reservedBy = "Nadeesha Hirushan"
            seats[index].contact = contactNumber
            seats[index].remark = remarks
        }
    }
}
