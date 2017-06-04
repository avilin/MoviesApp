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

    func validateLogin(username: String, password: String) throws {
        if username.isEmpty || password.isEmpty {
            throw ValidationError.emptyValues
        }
    }

    func validateRegister(username: String, password: String, confirmPassword: String) throws {
        if username.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            throw ValidationError.emptyValues
        }

        if username.characters.count < 5 {
            throw ValidationError.shortUsername
        }

        if password != confirmPassword {
            throw ValidationError.differentPasswords
        }

        if password.characters.count < 5 {
            throw ValidationError.shortPassword
        }
    }

    func loginWith(username: String, password: String, successCallback: @escaping () -> Void,
                   errorCallback: @escaping (String) -> Void) {
        userDAO.loginWith(username: username, password: password, successCallback: { [unowned self] user in
            self.storeUser(user, password: password)
            successCallback()
        }, errorCallback: errorCallback)
    }

    func registerWith(username: String, password: String, successCallback: @escaping () -> Void,
                      errorCallback: @escaping (String) -> Void) {
        userDAO.registerWith(username: username, password: password, successCallback: { [unowned self] user in
            self.storeUser(user, password: password)
            successCallback()
        }, errorCallback: errorCallback)
    }

    private func storeUser(_ user: User, password: String) {
        UserDefaults.standard.set(user.userID, forKey: "userID")
        UserDefaults.standard.set(user.username, forKey: "username")
        UserDefaults.standard.set(password, forKey: "password")
        UserDefaults.standard.set(user.avatarURL, forKey: "avatarURL")
    }

    func userLogged() -> Bool {
        let userID = UserDefaults.standard.integer(forKey: "userID")
        let username = UserDefaults.standard.string(forKey: "username")
        let password = UserDefaults.standard.string(forKey: "password")

        return userID != 0 && username != nil && password != nil
    }

    func loggedUser() -> User? {
        let storedUserID = UserDefaults.standard.integer(forKey: "userID")
        let storedUsername = UserDefaults.standard.string(forKey: "username")
        let storedAvatarURL = UserDefaults.standard.string(forKey: "avatarURL")

        guard storedUserID != 0, let username = storedUsername else {
            return nil
        }
        let user = User(userID: storedUserID, username: username, avatarURL: storedAvatarURL)
        return user
    }

}
