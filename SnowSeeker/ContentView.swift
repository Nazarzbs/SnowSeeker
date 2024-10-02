//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Nazar on 29/9/24.
//

import SwiftUI

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var sortType: SortType = .defaultType
    
    enum SortType {
        case name, country, runs, defaultType
    }
    
    var sortedResorts: [Resort] {
        switch sortType {
        case .name:
            return resorts.sorted { $0.name < $1.name }
        case .country:
            return resorts.sorted { $0.country < $1.country }
        case .runs:
            return resorts.sorted { $0.runs > $1.runs }
        case .defaultType:
            return resorts
        }
    }
    
    @State private var favorites = Favorites()
    @State private var searchText = ""
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            sortedResorts
        } else {
            sortedResorts.filter { $0.name.localizedStandardContains(searchText)}
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List(filteredResorts) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                .rect(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Picker("Sort", selection: $sortType) {
                            Text("Name").tag(SortType.name)
                            Text("Country").tag(SortType.country)
                            Text("Runs").tag(SortType.runs)
                            Text("Default").tag(SortType.defaultType)
                        }
                    } label: {
                        HStack {
                            Text("Sort")
                            Image(systemName: "line.horizontal.3.decrease.circle")
                        }
                        .foregroundColor(.white)
                    }
                }
            }
           
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
        } detail: {
            WelcomeView()
        }
       
        .environment(favorites)
    }
}

#Preview {
    ContentView()
}
