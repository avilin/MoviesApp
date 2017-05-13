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

    // MARK: - Properties
    var viewModel: RegisterViewModel?

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
        case confirmPasswordTextField:
            viewModel?.confirmPassword.onViewUpdated?(confirmPasswordTextField.text!)
        default:
            break
        }
    }

    @IBAction func registerTouched(_ sender: UIButton) {
        viewModel?.register()
    }

    @IBAction func cancelTouched(_ sender: UIButton) {
        dismiss(animated: true)
    }

    // MARK: - Custom functions
    func initBindings() {
        viewModel?.username.bindAndFireOnModelUpdated { [unowned self] (text) in
            self.usernameTextField.text = text
        }

        viewModel?.password.bindAndFireOnModelUpdated { [unowned self] (text) in
            self.passwordTextField.text = text
        }

        viewModel?.confirmPassword.bindAndFireOnModelUpdated { [unowned self] (text) in
            self.confirmPasswordTextField.text = text
        }
    }

    func styleScreen() {
        ViewStyler.style(backgroudView: view)
        ViewStyler.style(formMainButton: registerButton)
        ViewStyler.style(formButton: cancelButton)
    }

}
