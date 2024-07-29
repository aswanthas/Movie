//
//  CategoryItemView.swift
//  TestProject
//
//  Created by Ahfas Rinu on 16/01/24.
//

import SwiftUI
import Kingfisher

struct CategoryItemView: View {
    var categoryImage: URL
    var categoryName: String
    var body: some View {
        VStack(alignment: .leading) {
            KFImage(categoryImage)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
                .cornerRadius(5)
                .padding(EdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 4))
            Text(categoryName)
                .foregroundColor(.yellow)
                .font(.system(size: 18, weight: .regular, design: .rounded))
                .padding(.leading, 10)
        }
        .frame(alignment: .leading)
    }
}
