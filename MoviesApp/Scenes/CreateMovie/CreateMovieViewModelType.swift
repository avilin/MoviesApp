//
//  CreateMovieViewModelType.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 3/6/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

class CreateMovieViewModelType: CreateMovieViewModel {

    weak var backgroundTaskEventDelegate: BackgroundTaskEventDelegate?
    weak var backNavigationEventDelegate: BackNavigationEventDelegate?
    let movieService: MovieService
    let userService: UserService

    typealias OnCreateMovie = (Movie) -> Void
    let onCreateMovie: OnCreateMovie?

    let name: Binder<String>
    let synopsis: Binder<String>
    let movieLength: Binder<String>
    let releaseDate: Binder<String>
    let genre: Binder<String>
    let imageURL: Binder<String?>

    let enableImageURL = Binder(true)
    let imageData: Binder<Data?>
    let enableSave = Binder(false)

    init(backgroundTaskEventDelegate: BackgroundTaskEventDelegate,
         backNavigationEventDelegate: BackNavigationEventDelegate, movieService: MovieService, userService: UserService,
         onCreateMovie: OnCreateMovie?) {
        self.backgroundTaskEventDelegate = backgroundTaskEventDelegate
        self.backNavigationEventDelegate = backNavigationEventDelegate
        self.movieService = movieService
        self.userService = userService
        self.onCreateMovie = onCreateMovie

        name = Binder("")
        synopsis = Binder("")
        movieLength = Binder("")
        releaseDate = Binder("")
        genre = Binder("")
        imageURL = Binder("")

        imageData = Binder(nil)

        name.bindOnViewUpdated { [unowned self] (name) in
            self.name.value = name
            self.enableSave.value = self.validate()
        }

        synopsis.bindOnViewUpdated { [unowned self] (synopsis) in
            self.synopsis.value = synopsis
        }

        movieLength.bindOnViewUpdated { [unowned self] (movieLength) in
            if movieLength.isEmpty || Int(movieLength) != nil {
                self.movieLength.value = movieLength
            } else {
                self.movieLength.value = self.movieLength.value
            }
            self.enableSave.value = self.validate()
        }

        releaseDate.bindOnViewUpdated { [unowned self] (releaseDate) in
            if releaseDate.isEmpty || (releaseDate.characters.count < 5 && Int(releaseDate) != nil) {
                self.releaseDate.value = releaseDate
            } else {
                self.releaseDate.value = self.releaseDate.value
            }
            self.enableSave.value = self.validate()
        }

        genre.bindOnViewUpdated { [unowned self] (genre) in
            self.genre.value = genre
            self.enableSave.value = self.validate()
        }

        imageURL.bindOnViewUpdated { [unowned self] (imageURL) in
            self.imageURL.value = imageURL
            self.imageData.value = nil
        }

        imageData.bindOnViewUpdated { [unowned self] (imageData) in
            self.imageData.value = imageData
            self.enableImageURL.value = imageData == nil
            if imageData == nil {
                self.imageURL.value = self.imageURL.value
            }
        }

    }

    func create() {
        backgroundTaskEventDelegate?.showActivityIndicator()
        guard let user = userService.loggedUser() else {
            self.backgroundTaskEventDelegate?.hideActivityIndicator()
            self.backgroundTaskEventDelegate?.showAlert(title: "ERROR", message: "You must be logged to create a movie",
                                                        cancelActionText: "OK")
            return
        }

        let movie = Movie(name: name.value, synopsis: synopsis.value, movieLength: Int(movieLength.value)!,
                          releaseDate: Int(releaseDate.value)!, genre: genre.value, author: user.userID)

        movieService.create(movie: movie, imageURL: imageURL.value, imageData: imageData.value,
            successCallback: { [unowned self] movieID in
                self.backgroundTaskEventDelegate?.hideActivityIndicator()
                self.backNavigationEventDelegate?.goBack()
                movie.movieID = movieID
                self.onCreateMovie?(movie)
            }, errorCallback: { [unowned self] message in
                self.backgroundTaskEventDelegate?.hideActivityIndicator()
                self.backgroundTaskEventDelegate?.showAlert(title: "ERROR", message: message, cancelActionText: "OK")
        })
    }

    func validate() -> Bool {
        return movieService.validateMovieName(name.value) && movieService.validateMovieLength(movieLength.value)
            && movieService.validateMovieReleaseDate(releaseDate.value) && movieService.validateMovieGenre(genre.value)
    }
}
