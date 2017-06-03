//
//  UIViewControlllerExtensionShowAlert.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 3/6/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

extension UIViewController {

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)

        present(alert, animated: true)
    }

}
