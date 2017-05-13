//
//  RegisterViewModel.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 13/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

protocol RegisterViewModel {

    var username: Binder<String> { get }
    var password: Binder<String> { get }
    var confirmPassword: Binder<String> { get }

    func register()

}
