//
//  AddBookView.swift
//  Bookworm_4
//
//  Created by David Stanton on 3/19/24.
//
// AddBookView
// add modelContext, add dismiss
// Variables and fields to add title, author, genre, review, rating
// Button to add book, insert into modelContext, dismiss
// let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
import SwiftData
import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var author = ""
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var rating = 3
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Section("Add Review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }
                Section {
                    Button("Save Book") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating, date: .now)
                        modelContext.insert(newBook)
                        dismiss()
                    }
                }
                .disabled(title.isReallyEmpty || author.isReallyEmpty)
            }
            .navigationTitle("Add Book")
        }
    }
}

extension String {
    var isReallyEmpty: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
#Preview {
    AddBookView()
}
