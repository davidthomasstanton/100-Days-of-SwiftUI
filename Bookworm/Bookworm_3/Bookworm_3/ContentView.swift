//
//  ContentView.swift
//  Bookworm_3
//
//  Created by David Stanton on 3/16/24.
//
// Book model
// variables for title, author, genre, review, rating
// ContentView
// Property wrappers for modelContext, query for books, showingAddScreen
// Nav Stack with a List of books as Navlinks
// items in list have the EmojiRating, title and author
// toolbar with Button to add book
// AddBookView
// add modelContext, add dismiss
// Variables and fields to add title, author, genre, review, rating
// Button to add book, insert into modelContext, dismiss
// let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
// Rating View
// variables for rating (binded), maximumRating, offImage, onImage, offColor, onColor
// HStack that displays the label if it's not empty
// Go through the rating, 1->max rating (+1) and place a Button that sends back the number tapped, and displays the onColor if the star is equal or more than the number tapped
// function that sends an offImage in place of the onImage if it's number is higher than the rating
// EmojiRatingView
// switch that returns Emojis that correspond to the rating
// DetailView
// Image of genre underneath the text of the genre
// Display the Author, the review, the RatingView
// Preview{} do/try/catch
// create config, container, example book, then return the DetailView() with attached modelContainer

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var books: [Book]
    @State private var showingAddBook = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.title)
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .foregroundStyle(book.rating == 1 ? .red : .black)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                            .opacity(book.rating == 1 ? 0.5 : 1.0)
                        }
                    }
                    .navigationDestination(for: Book.self) { selection in
                        DetailView(book: selection)
                    }
                }
                .onDelete(perform: deleteBook)
            }
                .navigationTitle("Bookworm")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add Book", systemImage: "plus") {
                            showingAddBook.toggle()
                        }
                    }
                }
                .sheet(isPresented: $showingAddBook) {
                    AddBookView()
                }
        }
    }
    func deleteBook(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}
