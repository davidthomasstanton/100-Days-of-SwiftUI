//
//  Practice_ContentView.swift
//  iExpense
//
//  Created by David Stanton on 2/15/24.
//

import SwiftUI
// Struct of a single expense
// observe a class of an array of single expenses
// with a didSet, encode the addition to a JSON file then save with a key
// with a custom initializer, load the data then decode the JSON file
// List that iterates through the expenses by name and displays them
// toolbar button + that adds new expenses
// function to remove items
// .onDelete modifier to ForEach to remove items
struct ExpenseItem2: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

class Expenses2 {
    var items = [ExpenseItem2]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decoded = try? JSONDecoder().decode([ExpenseItem2].self, from: savedItems) {
                items = decoded
                return
            }
        }
        items = []
    }
    
}

struct Practice_ContentView: View {
    @State private var expenses = Expenses2()
    @State private var showingSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: "USD"))
                    }
                }
                .onDelete(perform: removeItem)
            }
            .navigationTitle("Expenses")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingSheet = true
                }
            }
            .sheet(isPresented: $showingSheet) {
                Practice_AddView2(expenses: expenses)
            }
        }
    }
    func removeItem(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    Practice_ContentView()
}