//
//  SpecificMovieModel.swift
//  TestProject
//
//  Created by Ahfas Rinu on 16/01/24.
//

import Foundation

struct specificCategoryModel: Decodable {
    let movies: [Movie]
}

struct Movie: Decodable, Identifiable {
    let id: Int
    let movieName: String
    let movieRating: Int
    let movieDescription: String
    let movieImage: String
    let categoryId: Int
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, movieName = "movie_name", movieRating = "movie_rating", movieDescription = "movie_description", movieImage = "movie_image", categoryId = "category_id", createdAt = "created_at", updatedAt = "updated_at"
    }
}
