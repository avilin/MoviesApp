//
//  MovieDetailViewController.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 3/6/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit
import ImageLoader

class MovieDetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var synopsisLabel: AppLabel!
    @IBOutlet weak var movieLengthLabel: AppLabel!
    @IBOutlet weak var releaseDateLabel: AppLabel!
    @IBOutlet weak var genreLabel: AppLabel!

    // MARK: - Properties
    var viewModel: MovieDetailViewModel?
    fileprivate let activityIndicator = AppActivityIndicator()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.image = #imageLiteral(resourceName: "movieImagePlaceholder")

        initBindings()

        activityIndicator.configure(for: view)
    }

    // MARK: - IBActions
    @IBAction func deleteTouched(_ sender: UIBarButtonItem) {
        let alertAction = UIAlertAction(title: "Delete", style: .destructive) { [unowned self] _ in
            self.viewModel?.delete()
        }
        showAlert(title: "Delete Movie",
                  message: "This action cannot be undone, ¿do you still want to continue?",
                  cancelActionText: "Cancel", alertStyle: .actionSheet, alertActions: alertAction)
    }

    // MARK: - Custom functions
    func initBindings() {
        viewModel?.name.bindAndFireOnModelUpdated { [unowned self] name in
            self.navigationItem.title = name
        }

        viewModel?.imageURL.bindAndFireOnModelUpdated { [unowned self] image in
            if let image = image {
                self.imageView.load.request(with: image)
            }
        }

        viewModel?.synopsis.bindAndFireOnModelUpdated { [unowned self] synopsis in
            self.synopsisLabel.text = synopsis
        }

        viewModel?.movieLength.bindAndFireOnModelUpdated { [unowned self] movieLength in
            self.movieLengthLabel.text = "\(movieLength) min"
        }

        viewModel?.releaseDate.bindAndFireOnModelUpdated { [unowned self] releaseDate in
            self.releaseDateLabel.text = releaseDate
        }

        viewModel?.genre.bindAndFireOnModelUpdated { [unowned self] genre in
            self.genreLabel.text = genre
        }
    }

}

// MARK: - BackgroundTaskEventDelegate
extension MovieDetailViewController: BackgroundTaskEventDelegate {

    func showActivityIndicator() {
        activityIndicator.show()
    }

    func hideActivityIndicator() {
        activityIndicator.hide()
    }

}

// MARK: - BackNavigationEventDelegate
extension MovieDetailViewController: BackNavigationEventDelegate {

    func goBack() {
        navigationController?.popViewController(animated: true)
    }

}
