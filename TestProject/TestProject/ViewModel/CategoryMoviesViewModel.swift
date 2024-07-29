//
//  CategoryMoviesViewModel.swift
//  TestProject
//
//  Created by Ahfas Rinu on 16/01/24.
//

import Foundation
import UIKit

class CategoryMoviesViewModel: ObservableObject {
    @Published var allCategoriesModel: AllCategoriesModel?
    @Published var specificCategoryModel: specificCategoryModel?
    fileprivate var movieCategoriesService = MovieCategoriesService()
    @Published var isLoading = true
    init() {
        movieCategoriesService.delegate = self
    }
    func getAllMoviewCategories() {
        movieCategoriesService.getAllMoviewCategories(apiEndpoint: .getAllCategories)
    }
    func getSpecificCategorieMoview(categoryId: Int) {
        movieCategoriesService.getSpecificCategorieMoview(apiEndpoint: .getCategoryMovies, categoryId: categoryId)
    }
    func uploadMovieDetails(categoryId: Int, movieName: String, movieRating: String, movieDescription: String, movieImage: UIImage) {
        movieCategoriesService.uploadMovieDetails(apiEndpoint: .uploadMovieDetails, categoryId: categoryId, movieName: movieName, movieRating: movieRating, movieDescription: movieDescription, movieImage: movieImage)
    }
    // Function to sort movies by top-rated
    func sortByTopRated(movies: [Movie]) -> [Movie] {
        return movies.sorted { $0.movieRating > $1.movieRating }
    }

    // Function to sort movies by low-rated
    func sortByLowRated(movies: [Movie]) -> [Movie] {
        return movies.sorted { $0.movieRating < $1.movieRating }
    }
}
extension CategoryMoviesViewModel: MovieCategoriesServiceDelegate {
    
    func allCategoriesMovieSuccessResponse(_ response: AllCategoriesModel) {
        self.allCategoriesModel = response
    }
    
    func allCategoriesMovieFailResponse() {
        isLoading = false
    }
    
    func specificCategorieMovieSuccessResponse(_ response: specificCategoryModel) {
        self.specificCategoryModel = response
    }
    
    func specificCategorieMovieFailResponse() {
        isLoading = false
    }
}
