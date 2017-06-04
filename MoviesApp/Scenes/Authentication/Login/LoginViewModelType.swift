//
//  LoginViewModelType.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 1/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

class LoginViewModelType: LoginViewModel {

    weak var backgroundTaskEventDelegate: BackgroundTaskEventDelegate?
    let userService: UserService
    let sceneRouter: SceneRouter

    let username: Binder<String>
    let password: Binder<String>

    init(backgroundTaskEventDelegate: BackgroundTaskEventDelegate, userService: UserService, sceneRouter: SceneRouter) {
        self.backgroundTaskEventDelegate = backgroundTaskEventDelegate
        self.userService = userService
        self.sceneRouter = sceneRouter

        username = Binder("")
        password = Binder("")

        username.bindOnViewUpdated { [unowned self] (string) in
            self.username.value = string
        }

        password.bindOnViewUpdated { [unowned self] (string) in
            self.password.value = string
        }
    }

    func logIn() {
        do {
            try userService.validateLogin(username: username.value, password: password.value)
            backgroundTaskEventDelegate?.showActivityIndicator()
            userService.loginWith(username: username.value, password: password.value,
                successCallback: { [unowned self] in
                    self.backgroundTaskEventDelegate?.hideActivityIndicator()
                    self.sceneRouter.showMovieCollection()
                }, errorCallback: { [unowned self] _, message in
                    self.backgroundTaskEventDelegate?.hideActivityIndicator()
                    self.backgroundTaskEventDelegate?.showAlert(title: "ERROR", message: message,
                                                                cancelActionText: "OK")
                })
        } catch {
            backgroundTaskEventDelegate?.showAlert(title: "ERROR", message: "All fields are required",
                                                   cancelActionText: "OK")
        }
    }

    func register() {
        self.sceneRouter.showRegister()
    }

}
