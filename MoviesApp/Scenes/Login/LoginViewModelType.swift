//
//  LoginViewModelType.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 1/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

class LoginViewModelType: LoginViewModel {

    let username: Binder<String>
    let password: Binder<String>

    init() {
        username = Binder("admin")
        password = Binder("admin")

        username.bindOnViewUpdated { [unowned self] (string) in
            self.username.value = string
        }

        password.bindOnViewUpdated { [unowned self] (string) in
            self.password.value = string
        }
    }

    func signIn() {
    }

}
