//
//  MovieCollectionViewController.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 27/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MovieCell"

class MovieCollectionViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Properties
    var viewModel: MovieCollectionViewModel?
    var activityIndicatorHelper = ActivityIndicatorHelper()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        automaticallyAdjustsScrollViewInsets = false

        initBindings()
        styleScreen()

        activityIndicatorHelper.createActivityIndicator(in: view)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel?.loadMovies()
    }

    // MARK: - Custom functions
    func initBindings() {
        viewModel?.movies.bindAndFireOnModelUpdated { [unowned self] _ in
            self.collectionView.reloadData()
        }
    }

    func styleScreen() {
        ViewStyler.style(backgroudView: view)
        ViewStyler.style(backgroudView: collectionView)
        if let navigationBar = navigationController?.navigationBar {
            ViewStyler.style(navigationView: navigationBar)
        }
    }

}

// MARK: - UICollectionViewDataSource
extension MovieCollectionViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.movies.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            as? MovieCell else {
            fatalError()
        }

        cell.imageView.backgroundColor = UIColor.white
        cell.nameLabel.text = viewModel?.movies.value[indexPath.row].name

        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 4
        cell.layer.cornerRadius = 10

        return cell
    }

}

// MARK: - UICollectionViewDelegate
extension MovieCollectionViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }

}

// MARK: - UICollectionViewDelegateFlowLayout
extension MovieCollectionViewController: UICollectionViewDelegateFlowLayout {

}

// MARK: - MovieCollectionEventsDelegate
extension MovieCollectionViewController: MovieCollectionEventsDelegate {

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
