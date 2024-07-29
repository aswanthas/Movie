//
//  AddMovieView.swift
//  TestProject
//
//  Created by Ahfas Rinu on 16/01/24.
//

import SwiftUI
import Kingfisher

enum ImageSourceType {
    case camera
    case gallery
}
struct AddMovieView: View {
    @EnvironmentObject var viewModel: CategoryMoviesViewModel
    var category: String
    var categoryId: Int
    @State private var movieName: String = ""
    @State private var movieDescription: String = ""
    @State private var movieRating: String = ""
    @State private var selectedImage = UIImage()
    @State private var isSourcePopupShowed: Bool = false
    @State private var isImagePickerPresented: Bool = false
    @State var imageSource: ImageSourceType = .camera
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
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
                Text("Add Movie")
                    .frame(alignment: .center)
                    .foregroundColor(.white)
                    .font(.system(size: 22, weight: .regular, design: .rounded))
                    .padding(.bottom, 24)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.2))
            HStack(spacing: 0) {
                Text("Adding to")
                    .frame(alignment: .leading)
                    .foregroundColor(.white)
                    .font(.system(size: 22, weight: .regular, design: .rounded))
                    .padding(.bottom, 24)
                Text(category)
                    .frame(alignment: .leading)
                    .foregroundColor(.yellow)
                    .font(.system(size: 22, weight: .regular, design: .rounded))
                    .padding(EdgeInsets(top: 0, leading: 4, bottom: 24, trailing: 0))
                Spacer()
            }
            .frame(alignment: .leading)
            .padding(EdgeInsets(top: 16, leading: 20, bottom: 0, trailing: 0))
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 12, trailing: 0))
            Text("Movie Title")
                .frame(alignment: .leading)
                .foregroundColor(.yellow)
                .font(.system(size: 22, weight: .regular, design: .rounded))
                .padding(EdgeInsets(top: 12, leading: 20, bottom: 16, trailing: 0))
            TextField("Enter name of movie", text: $movieName)
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 4, trailing: 20))
                .textFieldStyle(.plain)
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 12, trailing: 20))
            Text("Description")
                .frame(alignment: .leading)
                .foregroundColor(.yellow)
                .font(.system(size: 22, weight: .regular, design: .rounded))
                .padding(EdgeInsets(top: 12, leading: 20, bottom: 16, trailing: 0))
            TextField("Enter some detail about the movie.", text: $movieDescription)
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 4, trailing: 20))
                .textFieldStyle(.plain)
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 12, trailing: 20))
            Text("Rating")
                .frame(alignment: .leading)
                .foregroundColor(.yellow)
                .font(.system(size: 22, weight: .regular, design: .rounded))
                .padding(EdgeInsets(top: 12, leading: 20, bottom: 16, trailing: 0))
            TextField("Select Number", text: $movieRating)
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 4, trailing: 20))
                .textFieldStyle(.plain)
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 12, trailing: 20))
            Text("Upload Image")
                .frame(alignment: .leading)
                .foregroundColor(.yellow)
                .font(.system(size: 22, weight: .regular, design: .rounded))
                .padding(EdgeInsets(top: 12, leading: 20, bottom: 16, trailing: 0))
            Button(action: {
                //  Rate Later
                isSourcePopupShowed = true
            }, label: {
                Text("Choose Image")
                    .font(.system(size: 22, weight: .regular, design: .rounded))
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity, maxHeight: 48)
                    .background( RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.white, lineWidth: 1))
            })
            .padding(.horizontal, 20)
            Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 140)
                        .clipped()
                        .padding(EdgeInsets(top: 20, leading: 25, bottom: 12, trailing: 0))
            HStack(spacing: 0) {
                Button(action: {
                    clearAllField()
                }, label: {
                    Text("Cancel")
                        .font(.system(size: 22, weight: .regular, design: .rounded))
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity, maxHeight: 48)
                })
                .background(Color.gray.opacity(0.2))
                .cornerRadius(18)
                .padding(EdgeInsets(top: 3, leading: 4, bottom: 6, trailing: 4))
                Button(action: {
                    viewModel.uploadMovieDetails(categoryId: categoryId, movieName: movieName, movieRating: movieRating, movieDescription: movieDescription, movieImage: selectedImage)
                    clearAllField()
                }, label: {
                    Text("Confirm")
                        .font(.system(size: 22, weight: .regular, design: .rounded))
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, maxHeight: 48)
                })
                .background(Color.yellow)
                .cornerRadius(18)
                .padding(EdgeInsets(top: 3, leading: 4, bottom: 6, trailing: 4))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .navigationBarBackButtonHidden(true)
        .background(Color.black)
        .sheet(isPresented: $isImagePickerPresented) {
                           // ImagePicker(selectedImage: $selectedImage)
            if imageSource == .camera {
                ImagePicker(sourceType: .camera, selectedImage: $selectedImage)
            } else if imageSource == .gallery {
                ImagePicker(sourceType: .photoLibrary, selectedImage: $selectedImage)
            }
        }
        .alert(isPresented: $isSourcePopupShowed) {
                        Alert(
                            title: Text("Please Select Image"),
                            message: Text("Choose Image from Gallery or Camera"),
                            primaryButton: .default(Text("Gallery"), action: {
                                self.imageSource = .gallery
                                isSourcePopupShowed = false
                                isImagePickerPresented = true
                            }),
                            secondaryButton: .cancel(Text("Camera"), action: {
                                self.imageSource = .camera
                                isSourcePopupShowed = false
                                isImagePickerPresented = true
                            })
                        )
                    }
    }
}

extension AddMovieView {
    func clearAllField() {
        self.movieName = ""
        self.movieRating = ""
        self.movieDescription = ""
        self.selectedImage = UIImage()
    }
}
