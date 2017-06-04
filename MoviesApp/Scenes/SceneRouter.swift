//
//  SceneRouter.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 30/4/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class SceneRouter {

    private let window: UIWindow
    private let sceneAssembler: SceneAssembler

    init(window: UIWindow, sceneAssembler: SceneAssembler) {
        self.window = window
        self.sceneAssembler = sceneAssembler
    }

    private func showMain() {
        let authenticationViewController = sceneAssembler.assembleMain()
        window.rootViewController = authenticationViewController
        window.makeKeyAndVisible()
    }

    func showLogin() {
        if let authenticationViewController = topViewController() as? AuthenticationViewController {
            let loginViewController = sceneAssembler.assembleLogin(sceneRouter: self)
            authenticationViewController.changeContainer(loginViewController)
        } else {
            showMain()
            showLogin()
        }
    }

    func showRegister() {
        if let authenticationViewController = topViewController() as? AuthenticationViewController {
            let registerViewController = sceneAssembler.assembleRegister(sceneRouter: self)
            authenticationViewController.changeContainer(registerViewController)
        } else {
            showMain()
            showRegister()
        }
    }

    func showMovieCollection() {
        let movieCollectionViewController = sceneAssembler.assembleMovieCollection(sceneRouter: self)
        let navigationController = UINavigationController(rootViewController: movieCollectionViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func showMovieDetail(movie: Movie, onDeleteMovie: MovieDetailViewModelType.OnDeleteMovie?) {
        if let navigationController = topViewController()?.navigationController {
            let movieDetailViewController = sceneAssembler.assembleMovieDetail(movie: movie,
                                                                               onDeleteMovie: onDeleteMovie)

            navigationController.pushViewController(movieDetailViewController, animated: true)
        }
        // MovieDetail will only be shown from MovieCollection using the NavigationController.
        // Otherwise, something has been done wrong.
    }

    func showCreateMovie(onCreateMovie: CreateMovieViewModelType.OnCreateMovie?) {
        if let navigationController = topViewController()?.navigationController {
            let createMovieViewController = sceneAssembler.assembleCreateMovie(onCreateMovie: onCreateMovie)

            navigationController.pushViewController(createMovieViewController, animated: true)
        }
        // MovieDetail will only be shown from MovieCollection using the NavigationController.
        // Otherwise, something has been done wrong.
    }

    private func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController)
        -> UIViewController? {

        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }

}
