//
//  MovieDAO.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 27/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

protocol MovieDAO {

    func findAll(successCallback: @escaping ([Movie]) -> Void, errorCallback: @escaping (String) -> Void)

}
