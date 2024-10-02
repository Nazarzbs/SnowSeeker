//
//  SkiDetailsView.swift
//  SnowSeeker
//
//  Created by Nazar on 29/9/24.
//

import SwiftUI

struct SkiDetailsView: View {
    let resort: Resort
    
    var body: some View {
        Group {
            VStack {
                Label("Elevation", systemImage: "mountain.2")
                    .font(.caption.bold())
                    .foregroundColor(.secondary)
                
                Text("\(resort.elevation)m")
                    .font(.title2)
                    .foregroundColor(.primary)
            }
            
            VStack {
                Label("Snow", systemImage: "snowflake")
                    .font(.caption.bold())
                    .foregroundColor(.secondary)
                
                Text("\(resort.snowDepth)cm")
                    .font(.title2)
                    .foregroundColor(.primary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(2)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.2), radius: 3, x: 2, y: 2)
    }
}

#Preview {
    SkiDetailsView(resort: .example)
}
