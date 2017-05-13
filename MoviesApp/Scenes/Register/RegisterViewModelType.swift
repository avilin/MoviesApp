//
//  RegisterViewModelType.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 13/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

class RegisterViewModelType: RegisterViewModel {

    weak var registerEventsDelegate: RegisterEventsDelegate?
    let userService: UserService
    let sceneRouter: SceneRouter

    let username: Binder<String>
    let password: Binder<String>
    let confirmPassword: Binder<String>

    init(registerEventsDelegate: RegisterEventsDelegate, userService: UserService, sceneRouter: SceneRouter) {
        self.registerEventsDelegate = registerEventsDelegate
        self.userService = userService
        self.sceneRouter = sceneRouter

        username = Binder("")
        password = Binder("")
        confirmPassword = Binder("")

        username.bindOnViewUpdated { [unowned self] (string) in
            self.username.value = string
        }

        password.bindOnViewUpdated { [unowned self] (string) in
            self.password.value = string
        }

        confirmPassword.bindOnViewUpdated { [unowned self] (string) in
            self.confirmPassword.value = string
        }
    }

    func register() {

    }

}
