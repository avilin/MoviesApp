//
//  ValidationError.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 13/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

enum ValidationError: Error {

    case emptyValues
    case differentPasswords
    case shortUsername
    case shortPassword

}
