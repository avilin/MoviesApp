//
//  User.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 7/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

class User {

    let userID: Int
    let username: String
    let avatarURL: String?

    init(userID: Int, username: String, avatarURL: String?) {
        self.userID = userID
        self.username = username
        self.avatarURL = avatarURL
    }

}
