//
//  Movie.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 27/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

class Movie {

    var movieID: Int?
    let name: String
    let synopsis: String
    let movieLength: Int
    let releaseDate: Int
    let genre: String
    var imageURL: String?
    var thumbnailImageURL: String?
    let author: Int

    init(name: String, synopsis: String, movieLength: Int, releaseDate: Int, genre: String, author: Int) {
        self.name = name
        self.synopsis = synopsis
        self.movieLength = movieLength
        self.releaseDate = releaseDate
        self.genre = genre
        self.author = author
    }

    init(movieID: Int, name: String, synopsis: String, movieLength: Int, releaseDate: Int, genre: String,
         imageURL: String?, thumbnailImageURL: String?, author: Int) {
        self.movieID = movieID
        self.name = name
        self.synopsis = synopsis
        self.movieLength = movieLength
        self.releaseDate = releaseDate
        self.genre = genre
        self.imageURL = imageURL
        self.thumbnailImageURL = thumbnailImageURL
        self.author = author
    }

}
