//
//  LoginEventsDelegate.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 7/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

protocol LoginEventsDelegate: NSObjectProtocol {

    func showAlert(title: String, message: String)

}
