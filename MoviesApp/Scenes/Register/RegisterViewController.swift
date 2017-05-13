//
//  RegisterViewController.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 13/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        styleScreen()
    }

    // MARK: - IBActions
    @IBAction func editingChanged(_ sender: UITextField) {

    }

    @IBAction func registerTouched(_ sender: UIButton) {

    }

    @IBAction func cancelTouched(_ sender: UIButton) {
    }

    // MARK: - Custom functions
    func styleScreen() {
        ViewStyler.style(backgroudView: view)
        ViewStyler.style(formMainButton: registerButton)
        ViewStyler.style(formButton: cancelButton)
    }

}
