//
//  ConventionContactsApp.swift
//  ConventionContacts
//
//  Created by David Stanton on 4/17/24.
//
import SwiftData
import SwiftUI

@main
struct ConventionContactsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Contact.self)
    }
}
