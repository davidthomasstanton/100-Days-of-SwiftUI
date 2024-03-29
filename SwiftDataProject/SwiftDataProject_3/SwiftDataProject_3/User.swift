//
//  User.swift
//  SwiftDataProject_3
//
//  Created by David Stanton on 3/22/24.
//
// ==== User ====
// var: name, city, joinDate
import Foundation
import SwiftData

@Model
class User {
    var name: String
    var city: String
    var joinDate: Date
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}
