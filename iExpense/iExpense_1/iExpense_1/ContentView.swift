//
//  ContentView.swift
//  iExpense_1
//
//  Created by David Stanton on 3/25/24.
//
// ==== ContentView ====
// var: showingAddExpense, expenseType, sortOrder = [name, amount]
// NavStack with ExpenseView
// toolbar button to add expense, pulling up AddView sheet
// Menu to filter expenses by type: All | Personal / Business
// Menu to sort expenses by name / name.reverse / amount.low to high / amount.high to low
// ==== ExpenseItem ====
// class with name, type, amount
// ==== ExpenseSection ====
// modelContainer, expenses, localCurrency
// List that iterates through all expenses, showing name/type/amount (in local currency)
// init with type (defaulted to "All") and sortOrder of ExpenseItem
// create a query with a filter of #Predicate type: if "All" else return the type
// .onDelete will perform removefunction for item 
// ==== AddView ====
// var for modelContext, dismiss
// var: name, type, amount, types [Personal, Business], localCurrency
// NavStack with a form for adding new expenses
// toolbar with toolbaritems for save and cancel
// have a variable for expenses and types
// include a button on the toolbar to add item
import SwiftUI

struct ContentView: View {
    @State private var showingAddExpense = false
    @State private var expenseType = "All"
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount)
    ]
    var body: some View {
        NavigationStack {
            ExpenseView(type: expenseType, sortOrder: sortOrder)
                .navigationTitle("iExpenses")
                .toolbar {
                    Button("Add", systemImage: "plus") {
                        showingAddExpense = true
                    }
                    
                    Menu("Filter", systemImage: "line.3.horizontal.decrease.circle") {
                        Picker("Filter", selection: $expenseType) {
                            Text("Show All Expenses")
                                .tag("All")
                            
                            Divider()
                            
                            ForEach(AddView.types, id: \.self) { type in
                                Text(type)
                                    .tag(type)
                            }
                        }
                    }
                    
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort By", selection: $sortOrder) {
                            Text("Name (A-Z)")
                                .tag([
                                    SortDescriptor(\ExpenseItem.name),
                                    SortDescriptor(\ExpenseItem.amount)
                                ])
                            Text("Name (Z-A)")
                                .tag([
                                    SortDescriptor(\ExpenseItem.name, order: .reverse),
                                    SortDescriptor(\ExpenseItem.amount)
                                ])
                            Text("Amount (low to high)")
                                .tag([
                                    SortDescriptor(\ExpenseItem.amount),
                                    SortDescriptor(\ExpenseItem.name)
                                ])
                            Text("Amount (high to low)")
                                .tag([
                                    SortDescriptor(\ExpenseItem.amount, order: .reverse),
                                    SortDescriptor(\ExpenseItem.name)
                                ])
                        }
                    }
                }
                .sheet(isPresented: $showingAddExpense) {
                    AddView()
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: ExpenseItem.self)
}
