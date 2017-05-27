//
//  MovieCollectionEventsDelegate.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 27/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

protocol MovieCollectionEventsDelegate: NSObjectProtocol {

    func showAlert(title: String, message: String)
    func showActivityIndicator()
    func hideActivityIndicator()

}
