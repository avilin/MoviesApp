//
//  MovieCollectionViewController.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 27/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

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
        styleScreen()

        activityIndicatorHelper.createActivityIndicator(in: view)
    }

    // MARK: - Custom functions
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
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            as? MovieCell else {
            fatalError()
        }

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
