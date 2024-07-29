//
//  ContentView.swift
//  TestProject
//
//  Created by Ahfas Rinu on 16/01/24.
//

import SwiftUI
import Kingfisher

struct HomeCategoryView: View {
    @StateObject var viewModel = CategoryMoviesViewModel()
    private let twoColumnGrid = [GridItem(), GridItem()]
    @State var selectedCategoryId: Int = 0
    @State var selectedCategoryName: String = ""
    @State var isShowMovieList: Bool = false
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Next Movies")
                        .frame(alignment: .center)
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .regular, design: .rounded))
                        .padding(.bottom, 16)
                }
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.2))
//                Text("Next Movies")
//                    .frame(alignment: .center)
//                    .foregroundColor(.white)
//                    .font(.system(size: 22, weight: .regular, design: .rounded))
//                    .padding(.bottom, 24)
                if let movies = viewModel.allCategoriesModel?.movieCategories {
                    LazyVGrid(columns: twoColumnGrid, spacing: 0) {
                        ForEach(movies, id: \.id) { index in
                            CategoryItemView(categoryImage: index.categoryImage, categoryName: index.categoryName)
                                .onTapGesture {
                                    self.selectedCategoryId = index.id
                                    self.selectedCategoryName = index.categoryName
                                    isShowMovieList = true
                                }
                        }
                    }
                    .padding(EdgeInsets(top: 16, leading: 20, bottom: 0, trailing: 20))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
//            .padding(.horizontal, 20)
            .background(Color.black)
            .background(
                NavigationLink(destination: MovieListView(categoryId: selectedCategoryId, categoryName: selectedCategoryName).environmentObject(viewModel),
                               isActive: $isShowMovieList) { EmptyView() }.hidden()
                    
            )
            .onAppear {
                viewModel.getAllMoviewCategories()
            }
        }
        
    }
}

#Preview {
    HomeCategoryView()
}
