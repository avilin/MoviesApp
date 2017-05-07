//
//  UserDAORest.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 7/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

class UserDAORest: UserDAO {

    func loginWith(username: String, password: String, successCallback: (User) -> Void,
                   errorCallback: (String) -> Void) {
        if username == "admin" && password == "admin" {
            successCallback(User(userID: 0, email: "admin@email.com", username: "admin"))
        } else {
            errorCallback("Wrong login data")
        }
    }
}
