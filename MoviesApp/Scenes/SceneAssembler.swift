//
//  SceneAssembler.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 30/4/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class SceneAssembler {

    private let authenticationStoryboardName = "Authentication"
    private let moviesStoryboardName = "Movies"

    private let authenticationIdentifier = "Authentication"
    private let loginIdentifier = "Login"
    private let registerIdentifier = "Register"
    private let movieCollectionIdentifier = "MovieCollection"
    private let movieDetailIdentifier = "MovieDetail"
    private let createMovieIdentifier = "CreateMovie"

    private let userService: UserService
    private let movieService: MovieService

    init(userService: UserService, movieService: MovieService) {
        self.userService = userService
        self.movieService = movieService
    }

    func assembleMain() -> UIViewController {
        let authenticationViewController = viewController(inStoryboard: authenticationStoryboardName,
                                                          withIdentifier: authenticationIdentifier)
        return authenticationViewController
    }

    func assembleLogin(sceneRouter: SceneRouter) -> UIViewController {
        let loginViewController = viewController(inStoryboard: authenticationStoryboardName,
                                                 withIdentifier: loginIdentifier)

        if let loginViewController = loginViewController as? LoginViewController {
            let loginViewModel = LoginViewModelType(backgroundTaskEventDelegate: loginViewController,
                                                    userService: userService, sceneRouter: sceneRouter)

            loginViewController.viewModel = loginViewModel
        }

        return loginViewController
    }

    func assembleRegister(sceneRouter: SceneRouter) -> UIViewController {
        let registerViewController = viewController(inStoryboard: authenticationStoryboardName,
                                                    withIdentifier: registerIdentifier)

        if let registerViewController = registerViewController as? RegisterViewController {
            let registerViewModel = RegisterViewModelType(backgroundTaskEventDelegate: registerViewController,
                                                       userService: userService, sceneRouter: sceneRouter)

            registerViewController.viewModel = registerViewModel
        }

        return registerViewController
    }

    func assembleMovieCollection(sceneRouter: SceneRouter) -> UIViewController {
        let movieCollectionViewController = viewController(inStoryboard: moviesStoryboardName,
                                                           withIdentifier: movieCollectionIdentifier)

        if let movieCollectionViewController = movieCollectionViewController as? MovieCollectionViewController {
            let movieCollectionViewModel = MovieCollectionViewModelType(
                backgroundTaskEventDelegate: movieCollectionViewController, movieService: movieService,
                sceneRouter: sceneRouter)

            movieCollectionViewController.viewModel = movieCollectionViewModel
        }
        return movieCollectionViewController
    }

    func assembleMovieDetail(movie: Movie, onDeleteMovie: MovieDetailViewModelType.OnDeleteMovie?) -> UIViewController {
        let movieDetailViewController = viewController(inStoryboard: moviesStoryboardName,
                                                       withIdentifier: movieDetailIdentifier)

        if let movieDetailViewController = movieDetailViewController as? MovieDetailViewController {
            let movieDetailViewModel = MovieDetailViewModelType(backgroundTaskEventDelegate: movieDetailViewController,
                                                                backNavigationEventDelegate: movieDetailViewController,
                                                                movieService: movieService, movie: movie,
                                                                onDeleteMovie: onDeleteMovie)

            movieDetailViewController.viewModel = movieDetailViewModel
        }
        return movieDetailViewController
    }

    func assembleCreateMovie(sceneRouter: SceneRouter, onCreateMovie: CreateMovieViewModelType.OnCreateMovie?)
        -> UIViewController {

        let createMovieViewController = viewController(inStoryboard: moviesStoryboardName,
                                                       withIdentifier: createMovieIdentifier)

        if let createMovieViewController = createMovieViewController as? CreateMovieViewController {
            let createMovieViewModel = CreateMovieViewModelType(backgroundTaskEventDelegate: createMovieViewController,
                                                                backNavigationEventDelegate: createMovieViewController,
                                                                movieService: movieService, userService: userService,
                                                                onCreateMovie: onCreateMovie, sceneRouter: sceneRouter)

            createMovieViewController.viewModel = createMovieViewModel
        }
        return createMovieViewController
    }

    private func viewController(inStoryboard storyboardName: String, withIdentifier identifier: String)
        -> UIViewController {

        let storyboad = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboad.instantiateViewController(withIdentifier: identifier)
        return viewController
    }

}
