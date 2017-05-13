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
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!

    // MARK: - Properties
    var viewModel: LoginViewModel?
    var activityIndicatorHelper = ActivityIndicatorHelper()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initBindings()
        styleScreen()

        activityIndicatorHelper.createActivityIndicator(in: view)
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
        viewModel?.username.bindAndFireOnModelUpdated { [unowned self] (text) in
            self.usernameTextField.text = text
        }

        viewModel?.password.bindAndFireOnModelUpdated { [unowned self] (text) in
            self.passwordTextField.text = text
        }
    }

    func styleScreen() {
        ViewStyler.style(backgroudView: view)
        ViewStyler.style(formMainButton: logInButton)
        ViewStyler.style(formButton: registerButton)
    }

}

extension LoginViewController: LoginEventsDelegate {

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)

        present(alert, animated: true)
    }

    func showActivityIndicator() {
        activityIndicatorHelper.showActivityIndicator()
    }

    func hideActivityIndicator() {
        activityIndicatorHelper.hideActivityIndicator()
    }

}
