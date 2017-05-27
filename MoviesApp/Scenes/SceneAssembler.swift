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

    private let userService: UserService

    init(userService: UserService) {
        self.userService = userService
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
            let loginViewModel = LoginViewModelType(loginEventsDelegate: loginViewController, userService: userService,
                                                    sceneRouter: sceneRouter)
            loginViewController.viewModel = loginViewModel
        }

        return loginViewController
    }

    func assembleRegister(sceneRouter: SceneRouter) -> UIViewController {
        let registerViewController = viewController(inStoryboard: authenticationStoryboardName,
                                                    withIdentifier: registerIdentifier)

        if let registerViewController = registerViewController as? RegisterViewController {
            let registerViewModel = RegisterViewModelType(registerEventsDelegate: registerViewController,
                                                       userService: userService, sceneRouter: sceneRouter)
            registerViewController.viewModel = registerViewModel
        }

        return registerViewController
    }

    func assembleMovieCollection() -> UIViewController {
        let movieCollectionViewController = viewController(inStoryboard: moviesStoryboardName,
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
