//
//  Location.swift
//  BucketList
//
//  Created by David Stanton on 4/8/24.
//
// ==== Location struct ====
// Codable, Equatable, Identifiable
// var: id, name, description, longitude, latitude,
// computed property for coordinate
// debug code for example location
// func (==) that returns true if the compared Locations have the same id

import Foundation
import MapKit

struct Location: Codable, Equatable, Identifiable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    #if DEBUG
    static let example = Location(id: UUID(), name: "Buckingham Palace", description: "Lit by over 40,000 lightbulbs.", latitude: 51.501, longitude: -0.141)
    #endif
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
