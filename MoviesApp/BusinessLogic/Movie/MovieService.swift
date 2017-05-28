//
//  MovieService.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 27/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

class MovieService {

    let movieDAO: MovieDAO

    init(movieDAO: MovieDAO) {
        self.movieDAO = movieDAO
    }

    func loadMovies(successCallback: @escaping ([Movie]) -> Void, errorCallback: @escaping (String) -> Void) {
        movieDAO.findAll(successCallback: successCallback, errorCallback: errorCallback)
    }

}
