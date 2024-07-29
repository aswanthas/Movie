//
//  MovieCategoriesModel.swift
//  TestProject
//
//  Created by Ahfas Rinu on 16/01/24.
//

import Foundation

struct AllCategoriesModel: Decodable {
    let movieCategories: [MovieCategory]
    private enum CodingKeys: String, CodingKey {
           case movieCategories = "movie_categories"
    }
}

struct MovieCategory: Decodable {
    let id: Int
    let categoryName: String
    let categoryImage: URL
    let createdAt: String
    let updatedAt: String
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case categoryName = "category_name"
        case categoryImage = "category_image"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
