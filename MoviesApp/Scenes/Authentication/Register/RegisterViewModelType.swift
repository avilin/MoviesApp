//
//  RegisterViewModelType.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 13/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

class RegisterViewModelType: RegisterViewModel {

    weak var backgroundTaskEventDelegate: BackgroundTaskEventDelegate?
    let userService: UserService
    let sceneRouter: SceneRouter

    let username: Binder<String>
    let password: Binder<String>
    let confirmPassword: Binder<String>

    init(backgroundTaskEventDelegate: BackgroundTaskEventDelegate, userService: UserService, sceneRouter: SceneRouter) {
        self.backgroundTaskEventDelegate = backgroundTaskEventDelegate
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
            backgroundTaskEventDelegate?.showActivityIndicator()
            userService.registerWith(username: username.value, password: password.value,
                successCallback: { [unowned self] in
                    self.backgroundTaskEventDelegate?.hideActivityIndicator()
                    self.sceneRouter.showMovieCollection()
                }, errorCallback: { [unowned self] _, message in
                    self.backgroundTaskEventDelegate?.hideActivityIndicator()
                    self.backgroundTaskEventDelegate?.showAlert(title: "ERROR", message: message,
                                                                cancelActionText: "OK", cancelAction: nil)
                })
        } catch ValidationError.emptyValues {
            backgroundTaskEventDelegate?.showAlert(title: "ERROR", message: "All fields are required",
                                                   cancelActionText: "OK", cancelAction: nil)
        } catch ValidationError.shortUsername {
            backgroundTaskEventDelegate?.showAlert(title: "ERROR", message: "Username length must be 5 or more",
                                                   cancelActionText: "OK", cancelAction: nil)
        } catch ValidationError.differentPasswords {
            backgroundTaskEventDelegate?.showAlert(title: "ERROR", message: "Passwords must be the same",
                                                   cancelActionText: "OK", cancelAction: nil)
        } catch ValidationError.shortPassword {
            backgroundTaskEventDelegate?.showAlert(title: "ERROR", message: "Passwords length must be 5 or more",
                                                   cancelActionText: "OK", cancelAction: nil)
        } catch {

        }
    }

    func cancelRegister() {
        sceneRouter.showLogin()
    }

}
