//
//  CreateMovieViewModel.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 3/6/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

protocol CreateMovieViewModel {

    var name: Binder<String> { get }
    var synopsis: Binder<String> { get }
    var movieLength: Binder<String> { get }
    var releaseDate: Binder<String> { get }
    var genre: Binder<String> { get }
    var imageURL: Binder<String?> { get }

    var imageData: Binder<Data?> { get }
    var enableImageURL: Binder<Bool> { get }
    var enableSave: Binder<Bool> { get }

    func create()

}
