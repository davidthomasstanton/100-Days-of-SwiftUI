//
//  ContentView.swift
//  FancyUnderline
//
//  Created by David Stanton on 3/6/24.
//

import SwiftUI

struct ContentView: View {
    @State var currentTab: Int = 0
    var body: some View {
        ZStack(alignment: .top) {
            TabView(selection: self.$currentTab) {
                View1().tag(0)
                View2().tag(1)
                View3().tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .edgesIgnoringSafeArea(.all)
            
            TabBarView(currentTab: self.$currentTab)
        }
    }
}
struct TabBarView: View {
    @Binding var currentTab: Int
    @Namespace var namespace
    let tabBarOptions: [String] = ["Hello World", "This is", "Something Cool we're doing"]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(Array(zip(self.tabBarOptions.indices, self.tabBarOptions)),
                        id: \.0,
                        content: {
                            index, name in
                            TabBarItem(currentTab: self.$currentTab,
                                       namespace: namespace.self,
                                       tabBarItemName: name,
                                       tab: index)
                })
            }
            .padding(.horizontal)
        }
        .background(Color.white)
        .frame(height: 80)
        .edgesIgnoringSafeArea(.all)
    }
}
struct TabBarItem: View {
    @Binding var currentTab: Int
    let namespace: Namespace.ID
    let tabBarItemName: String
    var tab: Int
    var body: some View {
        Button {
            self.currentTab = tab
        } label: {
            VStack {
                Spacer()
                Text(tabBarItemName)
                if currentTab == tab {
                    Color.black
                        .frame(height: 2)
                        .matchedGeometryEffect(id: "underLine", in: namespace, properties: .frame)
                } else {
                    Color.clear.frame(height: 2)
                }
            }
            .animation(.spring(), value: self.currentTab)
        }
        .buttonStyle(.plain)
    }
}
#Preview {
    ContentView()
}
