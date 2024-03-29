//
//  ContentView.swift
//  Navigation
//
//  Created by David Stanton on 2/24/24.
//

import SwiftUI
struct DetailView2: View {
    var number: Int
    @Binding var path: [Int]
    var body: some View {
        NavigationLink("Go to Random Number", value: Int.random(in: 0...1000))
            .navigationTitle("Number: \(number)")
            .toolbar {
                Button("Home") {
                    path.removeAll()
                }
            }
    }
}
struct ContentView: View {
    @State private var pathStore = PathStore()
    var body: some View {
        NavigationStack(path: $pathStore.path) {
            DetailView2(number: 0, path: $pathStore.path)
                .navigationDestination(for: Int.self) { i in
                    DetailView2(number: i, path: $pathStore.path)
                }
        }
    }
}



#Preview {
    ContentView()
}
