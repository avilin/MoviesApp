//
//  MovieDetailViewModelType.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 3/6/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

class MovieDetailViewModelType: MovieDetailViewModel {

    weak var backgroundTaskEventDelegate: BackgroundTaskEventDelegate?
    weak var backNavigationEventDelegate: BackNavigationEventDelegate?
    let movieService: MovieService

    typealias OnDeleteMovie = (Int) -> Void
    let onDeleteMovie: OnDeleteMovie?

    let name: Binder<String>
    let synopsis: Binder<String>
    let movieLength: Binder<Int>
    let releaseDate: Binder<Int>
    let genre: Binder<String>
    let imageURL: Binder<String?>

    private let movie: Movie

    init(backgroundTaskEventDelegate: BackgroundTaskEventDelegate,
         backNavigationEventDelegate: BackNavigationEventDelegate, movieService: MovieService, movie: Movie,
         onDeleteMovie: OnDeleteMovie?) {
        self.backgroundTaskEventDelegate = backgroundTaskEventDelegate
        self.backNavigationEventDelegate = backNavigationEventDelegate
        self.movieService = movieService
        self.movie = movie
        self.onDeleteMovie = onDeleteMovie

        name = Binder(movie.name)
        synopsis = Binder(movie.synopsis)
        movieLength = Binder(movie.movieLength)
        releaseDate = Binder(movie.releaseDate)
        genre = Binder(movie.genre)
        imageURL = Binder(movie.imageURL)
    }

    func delete() {
        backgroundTaskEventDelegate?.showActivityIndicator()
        movieService.delete(movieID: movie.movieID, successCallback: { [unowned self] in
            self.backgroundTaskEventDelegate?.hideActivityIndicator()
            self.backNavigationEventDelegate?.goBack()
            self.onDeleteMovie?(self.movie.movieID)
        }, errorCallback: { [unowned self] message in
            self.backgroundTaskEventDelegate?.hideActivityIndicator()
            self.backgroundTaskEventDelegate?.showAlert(title: "ERROR", message: message, cancelActionText: "OK")
        })
    }

}
