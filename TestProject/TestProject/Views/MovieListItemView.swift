//
//  MovieListItemView.swift
//  TestProject
//
//  Created by Ahfas Rinu on 16/01/24.
//

import SwiftUI
import Kingfisher

struct MovieListItemView: View {
    var movieImage: String
    var movieName: String
    var description: String
    var starRating: Int
    var body: some View {
        HStack(spacing: 0) {
            KFImage(URL(string: "\(movieImage)"))
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
                .cornerRadius(5)
                .padding(EdgeInsets(top: 4, leading: 20, bottom: 4, trailing: 4))
            VStack(alignment: .leading) {
                Text(movieName)
                    .foregroundColor(.yellow)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .padding(EdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 16))
                StarRating(rating: starRating)
                    .padding(.leading, 6)
                Text(description)
                    .foregroundColor(.white)
                    .lineLimit(4)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .padding(EdgeInsets(top: 6, leading: 6, bottom: 4, trailing: 16))
            }
            Spacer()
        }
        .frame(alignment: .leading)
    }
}
