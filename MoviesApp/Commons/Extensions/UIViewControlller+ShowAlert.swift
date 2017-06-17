//
//  UIViewControlllerExtensionShowAlert.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 3/6/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

extension UIViewController {

    func showAlert(title: String, message: String, cancelActionText: String, cancelAction: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: cancelActionText, style: .cancel) { _ in
            cancelAction?()
        }
        alert.addAction(cancelAction)

        present(alert, animated: true)
    }

    func showAlert(title: String, message: String, cancelActionText: String, alertStyle: UIAlertControllerStyle,
                   alertActions: UIAlertAction...) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        let cancelAction = UIAlertAction(title: cancelActionText, style: .cancel, handler: nil)
        alert.addAction(cancelAction)

        for alertAction in alertActions {
            alert.addAction(alertAction)
        }

        present(alert, animated: true)
    }

}
