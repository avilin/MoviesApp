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

    var movies: ArrayBinder<MovieCellDTO>
    private var movieList: [Movie] = []

    init(movieCollectionEventsDelegate: MovieCollectionEventsDelegate, movieService: MovieService,
         sceneRouter: SceneRouter) {
        self.movieCollectionEventsDelegate = movieCollectionEventsDelegate
        self.movieService = movieService
        self.sceneRouter = sceneRouter

        let movieCellDTOList: [MovieCellDTO] = []
        movies = ArrayBinder(movieCellDTOList)
    }

    func loadMovies() {
        movieCollectionEventsDelegate?.showActivityIndicator()
        movieService.loadMovies(successCallback: { [unowned self] moviesResponse in
            self.movieList = moviesResponse
            self.movies.assignValue(value: self.movieList.map { (movie) -> MovieCellDTO in
                return self.movieToCellDTO(movie: movie)
            })
            self.movieCollectionEventsDelegate?.hideActivityIndicator()
        }, errorCallback: { [unowned self] message in
            self.movieCollectionEventsDelegate?.hideActivityIndicator()
            self.movieCollectionEventsDelegate?.showAlert(title: "ERROR", message: message)
        })
    }

    func selectMovie(at indexPath: IndexPath) {
        let movie = movieList[indexPath.row]
        sceneRouter.showMovieDetail(movie: movie)
    }

    private func movieToCellDTO(movie: Movie) -> MovieCellDTO {
        return MovieCellDTO(name: movie.name, thumbnailImageURL: movie.thumbnailImageURL)
    }

}
