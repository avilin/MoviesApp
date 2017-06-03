//
//  MovieDetailViewModelType.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 3/6/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

class MovieDetailViewModelType: MovieDetailViewModel {

    let name: Binder<String>
    let synopsis: Binder<String>
    let movieLength: Binder<Int>
    let releaseDate: Binder<String>
    let genre: Binder<String>
    let imageURL: Binder<String?>

    private let movie: Movie

    init(movie: Movie) {
        self.movie = movie

        name = Binder(movie.name)
        synopsis = Binder(movie.synopsis)
        movieLength = Binder(movie.movieLength)
        releaseDate = Binder(movie.releaseDate)
        genre = Binder(movie.genre)
        imageURL = Binder(movie.imageURL)
    }

}
