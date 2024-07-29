//
//  StarRating.swift
//  TestProject
//
//  Created by Ahfas Rinu on 16/01/24.
//

import SwiftUI

struct StarRating: View {
    let rating: Int
    let maxRating: Int

    init(rating: Int, maxRating: Int = 5) {
        self.rating = rating
        self.maxRating = maxRating
    }

    var body: some View {
        HStack {
            ForEach(1...maxRating, id: \.self) { index in
                Image(index <= rating ? "rating_star_full" : "rating_star_empty")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
        }
        .frame(alignment: .leading)
    }
}
