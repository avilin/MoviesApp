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
    private weak var currentViewController: UIViewController?

    init(window: UIWindow, sceneAssembler: SceneAssembler) {
        self.window = window
        self.sceneAssembler = sceneAssembler
    }

    private func showMain() {
        let authenticationViewController = sceneAssembler.assembleMain()
        currentViewController = authenticationViewController
        window.rootViewController = authenticationViewController
        window.makeKeyAndVisible()
    }

    func showLogin() {
        if let authenticationViewController = currentViewController as? AuthenticationViewController {
            let loginViewController = sceneAssembler.assembleLogin(sceneRouter: self)
            authenticationViewController.changeContainer(loginViewController)
        } else {
            showMain()
            showLogin()
        }
    }

    func showRegister() {
        if let authenticationViewController = currentViewController as? AuthenticationViewController {
            let registerViewController = sceneAssembler.assembleRegister(sceneRouter: self)
            authenticationViewController.changeContainer(registerViewController)
        } else {
            showMain()
            showRegister()
        }
    }

    func showMovieCollection() {
        let movieCollectionViewController = sceneAssembler.assembleMovieCollection()
        currentViewController = movieCollectionViewController
        let navigationController = UINavigationController(rootViewController: movieCollectionViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
