//
//  Card.swift
//  Flashzilla_2
//
//  Created by David Stanton on 5/1/24.
//

import Foundation

struct Card: Codable, Hashable, Identifiable {
    var id: UUID
    var prompt: String
    var answer: String
    static let example = Card(id: UUID(), prompt: "What is the greatest analog synth still in production?", answer: "The MOOG One")
}
