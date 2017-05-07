//
//  User.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 7/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

class User {

    let userID: Int
    let email: String
    let username: String

    init(userID: Int, email: String, username: String) {
        self.userID = userID
        self.email = email
        self.username = username
    }

}
