//
//  AppTableCell.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 4/6/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit
import ChameleonFramework

@IBDesignable
class AppTableCell: UITableViewCell {

    var appearance: BackgroundAppearance = .blue

    @IBInspectable var backgroundAppearanceAdapter: Int {
        get {
            return appearance.rawValue
        }
        set(index) {
            self.appearance = BackgroundAppearance(rawValue: index) ?? .blue
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        configureView()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        configureView()
    }

    private func configureView() {
        switch appearance {
        case .blue:
            backgroundColor = FlatSkyBlue()
        case .white:
            backgroundColor = FlatWhite()
        }
    }

}
