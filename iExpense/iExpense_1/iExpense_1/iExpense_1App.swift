//
//  iExpense_1App.swift
//  iExpense_1
//
//  Created by David Stanton on 3/25/24.
//
import SwiftData
import SwiftUI

@main
struct iExpense_1App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
