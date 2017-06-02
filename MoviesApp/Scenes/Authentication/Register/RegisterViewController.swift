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
    @IBOutlet weak var cancelButton: UIButton!

    // MARK: - Properties
    var viewModel: RegisterViewModel?
    fileprivate let activityIndicator = AppActivityIndicator()

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
        viewModel?.cancelRegister()
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

}

// MARK: - RegisterEventsDelegate
extension RegisterViewController: RegisterEventsDelegate {

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
