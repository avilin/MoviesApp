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
        do {
            try userService.validateRegister(username: username.value, password: password.value,
                                             confirmPassword: confirmPassword.value)
            registerEventsDelegate?.showActivityIndicator()
            userService.registerWith(username: username.value, password: password.value,
                successCallback: { [unowned self] in
                    self.registerEventsDelegate?.hideActivityIndicator()
                    self.sceneRouter.showMovieCollection()
                }, errorCallback: { [unowned self] message in
                    self.registerEventsDelegate?.hideActivityIndicator()
                    self.registerEventsDelegate?.showAlert(title: "ERROR", message: message)
                })
        } catch ValidationError.emptyValues {
            registerEventsDelegate?.showAlert(title: "ERROR", message: "All fields are required")
        } catch ValidationError.shortUsername {
            registerEventsDelegate?.showAlert(title: "ERROR", message: "Username length must be 5 or more")
        } catch ValidationError.differentPasswords {
            registerEventsDelegate?.showAlert(title: "ERROR", message: "Passwords must be the same")
        } catch ValidationError.shortPassword {
            registerEventsDelegate?.showAlert(title: "ERROR", message: "Passwords length must be 5 or more")
        } catch {

        }
    }

    func cancelRegister() {
        sceneRouter.showLogin()
    }

}
