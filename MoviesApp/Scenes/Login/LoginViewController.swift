//
//  LoginViewController.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 30/4/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var formView: UIView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!

    // MARK: - Properties
    var viewModel: LoginViewModel?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initBindings()
        styleScreen()
    }

    // MARK: - IBActions
    @IBAction func editingChanged(_ sender: UITextField) {
        switch sender {
        case usernameTextField:
            viewModel?.username.onViewUpdated?(usernameTextField.text!)
        case passwordTextField:
            viewModel?.password.onViewUpdated?(passwordTextField.text!)
        default:
            break
        }
    }

    @IBAction func signInTouched(_ sender: UIButton) {
        viewModel?.signIn()
    }

    // MARK: - Custom functions
    func initBindings() {
        viewModel?.username.bindAndFireOnModelUpdated { [unowned self] (text) in
            self.usernameTextField.text = text
        }

        viewModel?.password.bindAndFireOnModelUpdated { [unowned self] (text) in
            self.passwordTextField.text = text
        }
    }

    func styleScreen() {
        ViewStyler.style(backgroudView: view)
        ViewStyler.style(formView: formView)
        ViewStyler.style(formButton: signInButton)
    }

}
