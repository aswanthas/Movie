//
//  MovieListView.swift
//  TestProject
//
//  Created by Ahfas Rinu on 16/01/24.
//

import SwiftUI

enum TabType {
    case topRated
    case lowRated
}

struct MovieListView: View {
    var categoryId: Int
    var categoryName: String
    @State var isAddMoviePresented = false
    @State var selectedTab: TabType = .topRated
    @EnvironmentObject var viewModel: CategoryMoviesViewModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .foregroundColor(.yellow)
                        .scaledToFill()
                        .frame(width: 15, height: 12)
                })
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 15, trailing: 0))
                Spacer()
                Text("Next Movies")
                    .frame(alignment: .center)
                    .foregroundColor(.white)
                    .font(.system(size: 22, weight: .regular, design: .rounded))
                    .padding(.bottom, 24)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.2))
            tabView
            if selectedTab == .topRated {
                if let movies = viewModel.specificCategoryModel?.movies {
                    let topRatedMovies = viewModel.sortByTopRated(movies: movies)
                    ScrollView {
                        ForEach(topRatedMovies, id: \.id) { movie in
                            MovieListItemView(movieImage: movie.movieImage, movieName: movie.movieName, description: movie.movieDescription, starRating: movie.movieRating)
                        }
                    }
                }
            } else {
                if let movies = viewModel.specificCategoryModel?.movies {
                    let lowRatedMovies = viewModel.sortByLowRated(movies: movies)
                    ScrollView {
                        ForEach(lowRatedMovies, id: \.id) { movie in
                            MovieListItemView(movieImage: movie.movieImage, movieName: movie.movieName, description: movie.movieDescription, starRating: movie.movieRating)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .navigationBarBackButtonHidden(true)
        .background(Color.black)
        .overlay(
            ZStack {
                Spacer()
                Image("add_icon_circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 65, height: 65)
                    .padding(25)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .onTapGesture {
                        isAddMoviePresented = true
                    }
            }
        )
        .background(
            NavigationLink(destination: AddMovieView(category: categoryName, categoryId: categoryId).environmentObject(viewModel),
                           isActive: $isAddMoviePresented) { EmptyView() }.hidden()
                
        )
        .onAppear {
            viewModel.getSpecificCategorieMoview(categoryId: categoryId)
        }
    }
}

extension MovieListView {
    var tabView: some View {
        HStack(spacing: 0) {
            TabBarButton(tabItem: .topRated, foregroundColour: Color.yellow, title: "Top Rated", isSelected: selectedTab == .topRated ? true : false)
                .onTapGesture {
                    selectedTab = .topRated
                }
            TabBarButton(tabItem: .lowRated, foregroundColour: Color.yellow, title: "Low Rated", isSelected: selectedTab == .lowRated ? true : false)
                .onTapGesture {
                    selectedTab = .lowRated
                }
        }
        .padding(.top, 10)
    }
}
