//
//  UserDAO.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 7/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

protocol UserDAO {

    func loginWith(username: String, password: String, successCallback: @escaping (User) -> Void,
                   errorCallback: @escaping (ResponseStatus, String) -> Void)

    func registerWith(username: String, password: String, successCallback: @escaping (User) -> Void,
                      errorCallback: @escaping (ResponseStatus, String) -> Void)

}
