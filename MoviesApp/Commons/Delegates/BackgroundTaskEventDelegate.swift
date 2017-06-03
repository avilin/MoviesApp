//
//  BackgroundTaskEventDelegate.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 3/6/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

protocol BackgroundTaskEventDelegate: NSObjectProtocol {

    func showAlert(title: String, message: String)
    func showActivityIndicator()
    func hideActivityIndicator()

}
