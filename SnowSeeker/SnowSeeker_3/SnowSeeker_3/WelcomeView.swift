//
//  WelcomeView.swift
//  SnowSeeker_3
//
//  Created by David Stanton on 5/15/24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to SnowSeeker")
                .font(.largeTitle)
            Text("Please select a resort from the left hand menu; swipe from the edge to show it")
        }
    }
}

#Preview {
    WelcomeView()
}