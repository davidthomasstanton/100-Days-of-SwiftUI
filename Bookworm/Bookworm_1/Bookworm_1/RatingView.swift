//
//  RatingView.swift
//  Bookworm_1
//
//  Created by David Stanton on 3/16/24.
//
// Rating View
// variables for rating (binded), maximumRating, offImage, onImage, offColor, onColor
// HStack that displays the label if it's not empty
// Go through the rating, 1->max rating (+1) and place a Button that sends back the number tapped, and displays the onColor if the star is equal or more than the number tapped
// Make sure the buttons are individually tappable
// function that sends an offImage in place of the onImage if it's number is higher than the rating, otherwise send the onImage
import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    var label = ""
    var maxRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            
            ForEach(1..<maxRating + 1, id: \.self) { num in
                Button {
                    rating = num
                } label: {
                    image(for: num)
                        .foregroundStyle(num > rating ? offColor : onColor)
                }
            }
            .buttonStyle(.plain)
        }
    }
    func image(for number: Int) -> Image {
        if number > rating {
            offImage ?? onImage
        } else {
            onImage
        }
    }
}

#Preview {
    RatingView(rating: .constant(3))
}
