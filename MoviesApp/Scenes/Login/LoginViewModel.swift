//
//  LoginViewModel.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 1/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

protocol LoginViewModel {

    var username: Binder<String> { get }
    var password: Binder<String> { get }

    func logIn()

}
