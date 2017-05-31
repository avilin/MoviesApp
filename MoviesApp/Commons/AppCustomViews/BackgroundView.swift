//
//  BackgroundView.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 29/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit
import ChameleonFramework

@IBDesignable
class BackgroundView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()

        configureView()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        configureView()
    }

    private func configureView() {
        backgroundColor = FlatSkyBlue()
    }

}
