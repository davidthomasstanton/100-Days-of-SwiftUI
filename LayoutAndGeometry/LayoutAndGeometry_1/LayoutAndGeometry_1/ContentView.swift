//
//  ContentView.swift
//  LayoutAndGeometry_1
//
//  Created by David Stanton on 5/9/24.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .indigo, .purple]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        Text("Row: \(index)")
                            .font(.largeTitle)
                            .frame(maxWidth: .infinity)
                            .background(Color(
                                hue: min(1.0, proxy.frame(in: .global).minY / fullView.frame(in: .global).height),
                                saturation: 1.0, brightness: 1.0))
                            .rotation3DEffect(
                                .degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5,
                                axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
                            )
                            .opacity(proxy.frame(in: .global).minY / 300)
                            .scaleEffect(max(0.5, proxy.frame(in: .global).minY / 400))
                    }
                    .frame(height: 40)
                }
                .scrollTargetBehavior(.viewAligned)
            }
            .scrollTargetLayout()
        }
    }
}

#Preview {
    ContentView()
}
