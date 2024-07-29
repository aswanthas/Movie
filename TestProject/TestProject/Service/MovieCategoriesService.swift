//
//  MovieCategoriesService.swift
//  TestProject
//
//  Created by Ahfas Rinu on 16/01/24.
//

import Foundation
import Alamofire
import UIKit

protocol MovieCategoriesServiceDelegate: AnyObject {
    func allCategoriesMovieSuccessResponse(_ response: AllCategoriesModel)
    func allCategoriesMovieFailResponse()
    func specificCategorieMovieSuccessResponse(_ response: specificCategoryModel)
    func specificCategorieMovieFailResponse()
}
enum APIEndpoint {
    case getAllCategories
    case getCategoryMovies
    case uploadMovieDetails

    var url: String {
        switch self {
        case .getAllCategories:
            return "https://appcomdev.com/appcomtest/public/api/get-all-categories"
        case .getCategoryMovies:
            return "https://appcomdev.com/appcomtest/public/api/get-category-movies"
        case .uploadMovieDetails:
            return "https://appcomdev.com/appcomtest/public/api/add-new-movie"
        }
    }
}


class MovieCategoriesService {
    weak var delegate: MovieCategoriesServiceDelegate?
    let apiKey = "diCoecSW_ExSgIwHIXiZsH:APA91bHeW2d92n2TaSNm8TAmfyuP3rFWvia-Q-5aCiC2UD-XqDMP"
    var apiEndpoint: APIEndpoint?
}

extension MovieCategoriesService {
    // MARK: get All Movie Categories list data
    func getAllMoviewCategories(apiEndpoint: APIEndpoint) {
        let url = URL(string: apiEndpoint.url)!
        AF.request(url, method: .get, headers: ["Authorization": "\(apiKey)"])
                .responseDecodable(of: AllCategoriesModel.self) { response in
                    switch response.result {
                    case .success(let value):
                        // Handle successful decoding of JSON response
                        self.delegate?.allCategoriesMovieSuccessResponse(value)
                    case .failure:
                        // Handle failure
                        self.delegate?.allCategoriesMovieFailResponse()
                    }
                }
    }
    // MARK: get Specific Movie Categories list data
    func getSpecificCategorieMoview(apiEndpoint: APIEndpoint, categoryId: Int) {
        let url = URL(string: apiEndpoint.url)!
        let parameters: [String: Any] = [
            "category_id": categoryId
        ]
        AF.request(url, method: .get, parameters: parameters, headers: ["Authorization": "\(apiKey)"])
                .responseDecodable(of: specificCategoryModel.self) { response in
                    switch response.result {
                    case .success(let value):
                        // Handle successful decoding of JSON response
                        self.delegate?.specificCategorieMovieSuccessResponse(value)
                    case .failure:
                        // Handle failure
                        self.delegate?.specificCategorieMovieFailResponse()
                    }
                }
    }
    func uploadMovieDetails(apiEndpoint: APIEndpoint, categoryId: Int, movieName: String, movieRating: String, movieDescription: String, movieImage: UIImage) {
        let url = URL(string: apiEndpoint.url)!
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(Data("\(categoryId)".utf8), withName: "category_id")
            multipartFormData.append(Data(movieName.utf8), withName: "movie_name")
            multipartFormData.append(Data(movieRating.utf8), withName: "movie_rating")
            multipartFormData.append(Data(movieDescription.utf8), withName: "movie_description")
            
            if let imageData = movieImage.jpegData(compressionQuality: 0.8) {
                multipartFormData.append(imageData, withName: "movie_image", fileName: "image.jpg", mimeType: "image/jpeg")
            }
            
        }, to: url, headers: ["Authorization": apiKey])
        .response { response in
            switch response.result {
            case .success(let data):
                print("Success: \(String(describing: data))")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
