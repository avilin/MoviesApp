//
//  UserManagementFacade.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 7/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

class UserService {

    let userDAO: UserDAO

    init(userDAO: UserDAO) {
        self.userDAO = userDAO
    }

    func validateLogin(username: String, password: String) -> Bool {
        return !username.isEmpty && !password.isEmpty
    }

    func loginWith(username: String, password: String,
                   successCallback: (Void) -> Void, errorCallback: (String) -> Void) {
        userDAO.loginWith(username: username, password: password, successCallback: { _ in

        }, errorCallback: errorCallback)
    }

}
