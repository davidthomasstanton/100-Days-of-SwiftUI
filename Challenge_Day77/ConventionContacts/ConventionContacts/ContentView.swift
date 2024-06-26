//
//  ContentView.swift
//  ConventionContacts
//
//  Created by David Stanton on 4/17/24.
//
import PhotosUI
import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var selectedItem: PhotosPickerItem?
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Contact.name) private var contacts: [Contact]
    @State private var showingAddContact = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(contacts) { contact in
                    NavigationLink(value: contact) {
                        HStack {
                            VStack {
                                Text(contact.name)
                                Text(contact.company)
                            }
                            Spacer()
                                loadImage(for: contact)
                                    .resizable()
                                    .scaledToFit()
                        }
                        .frame(width: 250, height: 50)
                    }
                    .navigationDestination(for: Contact.self) { contact in
                        ContactView(contact: contact)
                    }
                }
            }
            .navigationTitle("ConventionContacts")
            .toolbar {
                Button("Add Contact", systemImage: "plus") {
                    showingAddContact.toggle()
                }
            }
            .sheet(isPresented: $showingAddContact) {
                AddContactView()
            }
        }
        
        

    }
    func loadImage(for contact: Contact) -> Image {
        guard let uiImage = UIImage(data: contact.photo) else { return Image("SquirtleHeadShot") }
        return Image(uiImage: uiImage)
    }
}

#Preview {
    ContentView()
}
