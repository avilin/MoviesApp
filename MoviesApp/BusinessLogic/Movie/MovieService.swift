//
//  MovieService.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 27/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

class MovieService {

    let movieDAO: MovieDAO

    init(movieDAO: MovieDAO) {
        self.movieDAO = movieDAO
    }

    func loadAll(successCallback: @escaping ([Movie]) -> Void, errorCallback: @escaping (String) -> Void) {
        movieDAO.findAll(successCallback: successCallback, errorCallback: errorCallback)
    }

    func delete(movieID: Int, successCallback: @escaping () -> Void, errorCallback: @escaping (String) -> Void) {
        movieDAO.delete(movieID: movieID, successCallback: successCallback, errorCallback: errorCallback)
    }

    func create(movie: Movie, imageURL: String?, imageData: Data?, successCallback: @escaping (Int) -> Void,
                errorCallback: @escaping (String) -> Void) {

        if let imageURL = imageURL {
            ImageUploadRest.uploadImageURL(imageURL: imageURL, successCallback: { (imageURL, thumbnailImageURL) in
                movie.imageURL = imageURL
                movie.thumbnailImageURL = thumbnailImageURL
                self.create(movie: movie, successCallback: successCallback, errorCallback: errorCallback)
            }, errorCallback: errorCallback)
        }
    }

    func create(movie: Movie, successCallback: @escaping (Int) -> Void, errorCallback: @escaping (String) -> Void) {
        errorCallback("")
    }

    // MARK: - Validations
    func validateMovieName(_ name: String) -> Bool {
        return !name.isEmpty
    }

    func validateMovieLength(_ movieLength: String) -> Bool {
        return !movieLength.isEmpty && Int(movieLength) != nil
    }

    func validateMovieReleaseDate(_ releaseDate: String) -> Bool {
        return !releaseDate.isEmpty && releaseDate.characters.count == 4 && Int(releaseDate) != nil
    }

    func validateMovieGenre(_ genre: String) -> Bool {
        return !genre.isEmpty
    }

}
