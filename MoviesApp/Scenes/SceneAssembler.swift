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
    private let loginIdentifier = "LoginViewController"

    private let userService: UserService
    private let userDAO: UserDAO

    init() {
        userDAO = UserDAORest()
        userService = UserService(userDAO: userDAO)
    }

    func assembleLogin() -> UIViewController {
        let storyboad = UIStoryboard(name: mainStoryboardName, bundle: nil)
        let loginViewController = storyboad.instantiateViewController(withIdentifier: loginIdentifier)

        if let loginViewController = loginViewController as? LoginViewController {
            let loginViewModel = LoginViewModelType(loginEventsDelegate: loginViewController, userService: userService)
            loginViewController.viewModel = loginViewModel
        }

        return loginViewController
    }

}
