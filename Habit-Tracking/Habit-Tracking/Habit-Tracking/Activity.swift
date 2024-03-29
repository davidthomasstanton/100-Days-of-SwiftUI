//
//  Activity.swift
//  Habit-Tracking
//
//  Created by David Stanton on 3/4/24.
//

import Foundation

struct Activity: Codable, Equatable, Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var timesCompleted: Int
    
    static var example = Activity(title: "Example Habit", description: "Description", timesCompleted: 0)
}
