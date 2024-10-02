//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Nazar on 29/9/24.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Environment(Favorites.self) var favorites
    
    @State private var selectedFacility: Facility?
    @State private var showingFacility = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .bottomTrailing) {
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                        .shadow(color: .black.opacity(0.4), radius: 3, x: 2, y: 2)  
                    
                    Text("Photo: \(resort.imageCredit)")
                        .font(.footnote)
                        .padding(4)
                        .background(Color.black.opacity(0.5))
                        .foregroundColor(.white)
                        .cornerRadius(4)
                        .padding([.bottom, .trailing], 5)
                        .shadow(color: .black.opacity(0.4), radius: 3, x: 2, y: 2)
                }
                
                HStack {
                    if horizontalSizeClass == .compact && dynamicTypeSize > .large {
                        VStack(spacing: 10) {
                            ResortDetailsView(resort: resort)
                        }
                        
                        VStack(spacing: 10) {
                            SkiDetailsView(resort: resort)
                        }
                    } else {
                        ResortDetailsView(resort: resort)
                        SkiDetailsView(resort: resort)
                    }
                }
                .padding(.vertical)
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text(resort.description)
                        .background(Color.primary.opacity(0.03))
                        .cornerRadius(8)
                    
                    Text("Facilities")
                        .font(.title2)
                        .padding(.top)
                        .bold()
                    
                    HStack(alignment: .center) {
                        ForEach(resort.facilityTypes) { facility in
                            Button {
                                selectedFacility = facility
                                showingFacility = true
                            } label: {
                                facility.icon
                                    .font(.title)
                                    .padding(10)
                                    .background(Color(.systemGray6))
                                    .foregroundColor(.black)
                                    .cornerRadius(10)
                                    .padding([.bottom, .trailing], 5)
                                    .shadow(color: .black.opacity(0.2), radius: 3, x: 2, y: 2)
                             
                            }
                            
                        }
                    }
                    
                    Text(resort.facilities, format: .list(type: .and))
                        .padding()
                        .background(Color(.systemGray6))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.2), radius: 3, x: 2, y: 2)
                }
                .padding(.horizontal)
                .padding(.top)
                
                Button {
                    if favorites.contains(resort) {
                        favorites.remove(resort)
                    } else {
                        favorites.add(resort)
                    }
                } label: {
                    HStack {
                        Image(systemName: favorites.contains(resort) ? "heart.fill" : "heart")  // Heart icon changes based on favorite status
                        Text(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites")
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(favorites.contains(resort) ? .red : .blue)
                .cornerRadius(10)
                .padding()
                .shadow(radius: 4)
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        .alert(selectedFacility?.name ?? "More information", isPresented: $showingFacility, presenting: selectedFacility) { _ in
        } message: { facility in
            Text(facility.description)
        }
    }
}

#Preview {
    ResortView(resort: .example)
        .environment(Favorites())
}
