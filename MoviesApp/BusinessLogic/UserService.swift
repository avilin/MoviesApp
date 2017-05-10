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
                   successCallback: @escaping (Void) -> Void, errorCallback: @escaping (String) -> Void) {
        userDAO.loginWith(username: username, password: password, successCallback: { [unowned self] user in
            self.storeUser(user, password: password)
            successCallback()
        }, errorCallback: errorCallback)
    }

    private func storeUser(_ user: User, password: String) {
        UserDefaults.standard.set(user.userID, forKey: "userID")
        UserDefaults.standard.set(user.email, forKey: "email")
        UserDefaults.standard.set(user.username, forKey: "username")
        UserDefaults.standard.set(password, forKey: "password")
    }

    func userLogged() -> Bool {
        let userID = UserDefaults.standard.integer(forKey: "userID")
        let email = UserDefaults.standard.string(forKey: "email")
        let username = UserDefaults.standard.string(forKey: "username")
        let password = UserDefaults.standard.string(forKey: "password")

        return userID != 0 && email != nil && username != nil && password != nil
    }

}
