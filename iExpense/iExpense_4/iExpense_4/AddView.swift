//
//  AddView.swift
//  iExpense_4
//
//  Created by David Stanton on 3/26/24.
//
// ==== AddView ====
// var for modelContext, dismiss
// var: name, type, amount, types [Personal, Business], localCurrency
// NavStack with a form for adding new expenses
// toolbar with toolbaritems for save and cancel
// have a variable for expenses and types
// include a button on the toolbar to add item
import SwiftData
import SwiftUI

struct AddView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount: Decimal = 0.0
    static let types = ["Personal", "Business"]
    //let localCurrency = Locale.current.currency?.identifier ?? "USD"
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                TextField("Amount", value: $amount, format: .currency(code: ExpenseItem.localCurrency))
            }
            .navigationTitle("Add Expense")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save", systemImage: "plus") {
                        let newItem = ExpenseItem(name: name, type: type, amount: amount)
                        modelContext.insert(newItem)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddView()
}
