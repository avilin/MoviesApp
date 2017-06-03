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
        viewModel?.username.bindAndFireOnModelUpdated { [unowned self] username in
            self.usernameTextField.text = username
        }

        viewModel?.password.bindAndFireOnModelUpdated { [unowned self] password in
            self.passwordTextField.text = password
        }

        viewModel?.confirmPassword.bindAndFireOnModelUpdated { [unowned self] confirmPassword in
            self.confirmPasswordTextField.text = confirmPassword
        }
    }

}

// MARK: - BackgroundTaskEventDelegate
extension RegisterViewController: BackgroundTaskEventDelegate {

    func showActivityIndicator() {
        activityIndicator.show()
    }

    func hideActivityIndicator() {
        activityIndicator.hide()
    }

}
