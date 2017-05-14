//
//  AuthenticationViewController.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 14/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var containerView: UIView!

    // MARK: - Properties
    private weak var currentViewController: UIViewController?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        styleScreen()
    }

    // MARK: - Custom functions
    func styleScreen() {
        ViewStyler.style(backgroudView: view)
    }

    func changeContainer(_ viewController: UIViewController) {
        if let currentViewController = currentViewController {
            removeViewController(currentViewController)
        }
        addViewController(viewController)
    }

    private func addViewController(_ viewController: UIViewController) {
        currentViewController = viewController

        addChildViewController(viewController)
        containerView.addSubview(viewController.view)

        containerView.heightAnchor.constraint(equalToConstant: viewController.view.frame.size.height)

        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor)
            ])

        viewController.didMove(toParentViewController: self)
    }

    private func removeViewController(_ viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }

}
