//
//  Favorites.swift
//  SnowSeeker_2
//
//  Created by David Stanton on 5/16/24.
//

import SwiftUI

@Observable
class Favorites {
    private var favorites = Set<String>()
    private let key = "Favorites"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: key) {
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
                favorites = decoded
                return
            }
        }
        favorites = []
    }
    
    func save() {
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.setValue(data, forKey: key)
        }
    }
    
    func contains(_ resort: Resort) -> Bool {
        favorites.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        favorites.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        favorites.remove(resort.id)
        save()
    }
}
