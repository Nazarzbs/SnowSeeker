//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Nazar on 30/9/24.
//

import SwiftUI

@Observable
class Favorites {
   
    private var resorts: Set<String>
    private let key = "Favorite"
    
    init() {
        let defaults = UserDefaults.standard
        // Load the array from UserDefaults and convert it to a Set
        if let savedResorts = defaults.object(forKey: key) as? [String] {
            resorts = Set(savedResorts)
        } else {
            resorts = Set<String>()
        }
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        let defaults = UserDefaults.standard
       
        defaults.set(Array(resorts), forKey: key)
    }
}
