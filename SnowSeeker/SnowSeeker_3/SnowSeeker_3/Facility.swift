//
//  Facility.swift
//  SnowSeeker_3
//
//  Created by David Stanton on 5/16/24.
//

import SwiftUI

struct Facility: Identifiable {
    let id = UUID()
    let name: String
    
    private let icons = [
        "Accommodation": "house",
        "Beginners": "1.circle",
        "Cross-country": "map",
        "Eco-friendly": "leaf.arrow.circlepath",
        "Family": "person.3"
    ]
    
    private let descriptions = [
        "Accommodation": "This resort has popular on-site accomodations.",
        "Beginners": "This resort has lots of ski schools.",
        "Cross-country": "This resort has many cross-country ski routes.",
        "Eco-friendly": "This resort ha won an award for environment friendliness.",
        "Family": "This resort is popular with families."
    ]
    
    var icon: some View {
        if let iconName = icons[name] {
            Image(systemName: iconName)
                .accessibilityLabel(name)
                .foregroundStyle(.secondary)
        } else {
            fatalError("Unknown facility type: \(name)")
        }
    }
    
    var description: String {
        if let message = descriptions[name] {
            message
        } else {
            fatalError("Unkown facility type: \(name)")
        }
    }
}