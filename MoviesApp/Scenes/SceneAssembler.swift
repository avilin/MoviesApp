//
//  SceneAssembler.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 30/4/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class SceneAssembler {

    private let mainStoryboardName = "Main"
    private let loginIdentifier = "Login"
    private let movieCollectionIdentifier = "MovieCollection"

    private let userService: UserService

    init(userService: UserService) {
        self.userService = userService
    }

    func assembleLogin(sceneRouter: SceneRouter) -> UIViewController {
        let loginViewController = viewController(inStoryboard: mainStoryboardName, withIdentifier: loginIdentifier)

        if let loginViewController = loginViewController as? LoginViewController {
            let loginViewModel = LoginViewModelType(loginEventsDelegate: loginViewController, userService: userService,
                                                    sceneRouter: sceneRouter)
            loginViewController.viewModel = loginViewModel
        }

        return loginViewController
    }

    func assembleMovieCollection() -> UIViewController {
        let movieCollectionViewController = viewController(inStoryboard: mainStoryboardName,
                                                           withIdentifier: movieCollectionIdentifier)
        return movieCollectionViewController
    }

    private func viewController(inStoryboard storyboardName: String, withIdentifier identifier: String)
        -> UIViewController {

        let storyboad = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboad.instantiateViewController(withIdentifier: identifier)
        return viewController
    }

}
