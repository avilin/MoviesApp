//
//  ParserError.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 9/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

enum ParseError: Error {

    case parserNotFound
    case responseFieldNotFound
    case entityFieldNotFound

}
