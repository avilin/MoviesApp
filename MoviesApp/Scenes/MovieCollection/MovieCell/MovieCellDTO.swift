//
//  MovieCellViewModel.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 3/6/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

class MovieCellDTO {

    let name: String
    let thumbnailImageURL: String?

    init(name: String, thumbnailImageURL: String?) {
        self.name = name
        self.thumbnailImageURL = thumbnailImageURL
    }

}
