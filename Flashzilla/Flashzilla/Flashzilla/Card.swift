//
//  Card.swift
//  Flashzilla
//
//  Created by David Stanton on 5/1/24.
//
// struct Card
// Codable, Equatable, Hashable, Identifiable
// var for id, prompt, answer, example
import Foundation


struct Card: Codable, Equatable, Hashable, Identifiable {
    var id = UUID()
    var prompt: String
    var answer: String
    
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor who?", answer: "Jodie Whittaker")
}
