//
//  ExpenseView.swift
//  iExpense_1
//
//  Created by David Stanton on 3/25/24.
//
// ==== ExpenseSection ====
// modelContainer, expenses, localCurrency
// List that iterates through all expenses, showing name/type/amount (in local currency)
// init with type (defaulted to "All") and sortOrder of ExpenseItem
// create a query with a filter of #Predicate type: if "All" else return the type
// .onDelete will perform removefunction for item 
import SwiftData
import SwiftUI

struct ExpenseView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var expenses: [ExpenseItem]
    let localCurrency = Locale.current.currency?.identifier ?? "USD"
    
    var body: some View {
        List {
            ForEach(expenses) { expense in
                HStack {
                    VStack(alignment: .leading) {
                        Text(expense.name)
                        Text(expense.type)
                    }
                    Spacer()
                    Text(expense.amount, format: .currency(code: localCurrency))
                }
            }
            .onDelete(perform: removeItems)
        }
    }
    
    init(type: String = "All", sortOrder: [SortDescriptor<ExpenseItem>]) {
        _expenses = Query(filter: #Predicate {
            if type == "All" {
                return true
            } else {
                return $0.type == type
            }
        }, sort: sortOrder)

    }
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let item = expenses[offset]
            modelContext.delete(item)
        }
    }
}

#Preview {
    ExpenseView(sortOrder: [SortDescriptor(\ExpenseItem.name)])
        .modelContainer(for: ExpenseItem.self)
}
