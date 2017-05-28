//
//  MovieCollectionViewModelType.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 27/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

class MovieCollectionViewModelType: MovieCollectionViewModel {

    weak var movieCollectionEventsDelegate: MovieCollectionEventsDelegate?
    let movieService: MovieService
    let sceneRouter: SceneRouter

    var movies: Binder<[Movie]>

    init(movieCollectionEventsDelegate: MovieCollectionEventsDelegate, movieService: MovieService,
         sceneRouter: SceneRouter) {
        self.movieCollectionEventsDelegate = movieCollectionEventsDelegate
        self.movieService = movieService
        self.sceneRouter = sceneRouter

        movies = Binder([])
    }

    func loadMovies() {
        movieService.loadMovies(successCallback: { [unowned self] moviesResponse in
            self.movies.value = moviesResponse
            self.movieCollectionEventsDelegate?.hideActivityIndicator()
        }, errorCallback: { [unowned self] message in
            self.movieCollectionEventsDelegate?.hideActivityIndicator()
            self.movieCollectionEventsDelegate?.showAlert(title: "ERROR", message: message)
        })
    }

}
