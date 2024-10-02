//
//  ResortDetailsView.swift
//  SnowSeeker
//
//  Created by Nazar on 29/9/24.
//

import SwiftUI

struct ResortDetailsView: View {
    let resort: Resort
    
    var size: String {
        switch resort.size {
        case 1:
            "Small"
        case 2:
            "Average"
        default:
            "Large"
        }
    }
    
    var price: String {
        String(repeating: "$", count: resort.price)
    }
    
    var body: some View {
        Group {
            VStack {
                Label("Size", systemImage: "ruler.fill")
                    .font(.caption.bold())
                    .foregroundColor(.secondary)
                
                Text(size)
                    .font(.title2)
                    .foregroundColor(.primary)
            }
            
            VStack{
                Label("Price", systemImage: "dollarsign.circle")
                    .font(.caption.bold())
                    .foregroundColor(.secondary)
                
                Text(price)
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
    ResortDetailsView(resort: .example)
}
