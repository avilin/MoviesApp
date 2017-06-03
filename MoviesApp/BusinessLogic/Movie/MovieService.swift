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

    func loadAll(successCallback: @escaping ([Movie]) -> Void, errorCallback: @escaping (String) -> Void) {
        movieDAO.findAll(successCallback: successCallback, errorCallback: errorCallback)
    }

    func delete(movieID: Int, successCallback: @escaping () -> Void, errorCallback: @escaping (String) -> Void) {
        movieDAO.delete(movieID: movieID, successCallback: successCallback, errorCallback: errorCallback)
    }

}
