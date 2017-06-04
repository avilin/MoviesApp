//
//  MovieCollectionViewModel.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 27/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

protocol MovieCollectionViewModel {

    var movies: ArrayBinder<MovieCellDTO> { get }

    func loadMovies()

    func selectMovie(at indexPath: IndexPath)

    func createMovie()

}
