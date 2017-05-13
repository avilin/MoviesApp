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

    func showLogin() {
        let loginViewController = sceneAssembler.assembleLogin(sceneRouter: self)
        currentViewController = loginViewController
        window.rootViewController = loginViewController
        window.makeKeyAndVisible()
    }

    func showRegister() {
        if let currentViewController = currentViewController {
            let registerViewController = sceneAssembler.assembleRegister(sceneRouter: self)
            currentViewController.present(registerViewController, animated: true)
        }
    }

    func showMovieCollection() {
        let movieCollectionViewController = sceneAssembler.assembleMovieCollection()
        currentViewController = movieCollectionViewController
        window.rootViewController = movieCollectionViewController
        window.makeKeyAndVisible()
    }
}
