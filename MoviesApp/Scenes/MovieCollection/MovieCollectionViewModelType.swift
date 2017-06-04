//
//  MovieCollectionViewModelType.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 27/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

class MovieCollectionViewModelType: MovieCollectionViewModel {

    weak var backgroundTaskEventDelegate: BackgroundTaskEventDelegate?
    let movieService: MovieService
    let sceneRouter: SceneRouter

    var movies: ArrayBinder<MovieCellDTO>
    private var movieList: [Movie] = []

    init(backgroundTaskEventDelegate: BackgroundTaskEventDelegate, movieService: MovieService,
         sceneRouter: SceneRouter) {
        self.backgroundTaskEventDelegate = backgroundTaskEventDelegate
        self.movieService = movieService
        self.sceneRouter = sceneRouter

        let movieCellDTOList: [MovieCellDTO] = []
        movies = ArrayBinder(movieCellDTOList)
    }

    func loadMovies() {
        backgroundTaskEventDelegate?.showActivityIndicator()
        movieService.loadAll(successCallback: { [unowned self] moviesResponse in
            self.movieList = moviesResponse
            self.movies.assignValue(value: self.movieList.map { (movie) -> MovieCellDTO in
                return self.movieToCellDTO(movie: movie)
            })
            self.backgroundTaskEventDelegate?.hideActivityIndicator()
        }, errorCallback: { [unowned self] message in
            self.backgroundTaskEventDelegate?.hideActivityIndicator()
            self.backgroundTaskEventDelegate?.showAlert(title: "ERROR", message: message, cancelActionText: "OK")
        })
    }

    func selectMovie(at indexPath: IndexPath) {
        let movie = movieList[indexPath.row]
        sceneRouter.showMovieDetail(movie: movie) { [unowned self] (movieID) in
            self.deleteMovie(withID: movieID)
        }
    }

    func createMovie() {
        sceneRouter.showCreateMovie { [unowned self] (movie) in
            self.addMovie(movie)
        }
    }

    func addMovie(_ movie: Movie) {
        movieList.append(movie)
        movies.addElement(movieToCellDTO(movie: movie))
    }

    func deleteMovie(withID movieID: Int) {
        let index = movieList.index { (movie) -> Bool in
            return movie.movieID == movieID
        }

        if let index = index {
            movieList.remove(at: index)
            movies.removeElement(at: index)
        }
    }

    private func movieToCellDTO(movie: Movie) -> MovieCellDTO {
        return MovieCellDTO(name: movie.name, thumbnailImageURL: movie.thumbnailImageURL)
    }

}
