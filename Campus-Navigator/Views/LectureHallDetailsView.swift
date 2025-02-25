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
    
    var body: some View {
        VStack {
            Text(name)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("Location: \(floor)")
                .font(.title3)
        }
        .navigationTitle("Lecture Hall Details")
        .padding()
    }
}
