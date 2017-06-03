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
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!

    // MARK: - Properties
    var viewModel: LoginViewModel?
    fileprivate let activityIndicator = AppActivityIndicator()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initBindings()

        if let parentView = self.parent?.view {
            activityIndicator.configure(for: parentView)
        }
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

    @IBAction func logInTouched(_ sender: UIButton) {
        viewModel?.logIn()
    }

    @IBAction func registerTouched(_ sender: UIButton) {
        viewModel?.register()
    }

    // MARK: - Custom functions
    func initBindings() {
        viewModel?.username.bindAndFireOnModelUpdated { [unowned self] username in
            self.usernameTextField.text = username
        }

        viewModel?.password.bindAndFireOnModelUpdated { [unowned self] password in
            self.passwordTextField.text = password
        }
    }

}

// MARK: - LoginEventsDelegate
extension LoginViewController: LoginEventsDelegate {

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)

        present(alert, animated: true)
    }

    func showActivityIndicator() {
        activityIndicator.show()
    }

    func hideActivityIndicator() {
        activityIndicator.hide()
    }

}
