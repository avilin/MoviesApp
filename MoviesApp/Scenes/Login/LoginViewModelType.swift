//
//  LoginViewModelType.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 1/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

class LoginViewModelType: LoginViewModel {

    weak var loginEventsDelegate: LoginEventsDelegate?
    let userService: UserService

    let username: Binder<String>
    let password: Binder<String>

    init(loginEventsDelegate: LoginEventsDelegate, userService: UserService) {
        self.loginEventsDelegate = loginEventsDelegate
        self.userService = userService

        username = Binder("admin")
        password = Binder("admin")

        username.bindOnViewUpdated { [unowned self] (string) in
            self.username.value = string
        }

        password.bindOnViewUpdated { [unowned self] (string) in
            self.password.value = string
        }
    }

    func logIn() {
        if userService.validateLogin(username: username.value, password: password.value) {
            userService.loginWith(username: username.value, password: password.value, successCallback: {

            }, errorCallback: { message in
                loginEventsDelegate?.showAlert(title: "ERROR", message: message)
            })
        } else {
            loginEventsDelegate?.showAlert(title: "ERROR", message: "Username and password must not be empty")
        }
    }

}
