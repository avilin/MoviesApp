//
//  UIViewController+HideKeyboard.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 17/6/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class HideKeyboardOnTapHelper {

    private var tapGestureRecognizer: UITapGestureRecognizer?
    private weak var view: UIView?

    func configureTapRecognizer(view: UIView) {
        self.view = view
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer!)
    }

    @objc private func dismissKeyboard() {
        view?.endEditing(true)
    }

    func releaseTapRecognizer() {
        view?.removeGestureRecognizer(tapGestureRecognizer!)
        tapGestureRecognizer = nil
    }
}
