//
//  MovieCell.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 27/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit
import ChameleonFramework

class MovieCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    // MARK: - Configuration
    override func awakeFromNib() {
        super.awakeFromNib()

        configureView()
    }

    private func configureView() {
        layer.cornerRadius = 10
    }

}
