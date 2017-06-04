//
//  AppLabel.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 3/6/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation
import ChameleonFramework

@IBDesignable
class AppLabel: UILabel {

    var appearance: AppLabelAppearance = .normalWhite

    @IBInspectable var appLabelAppearanceAdapter: Int {
        get {
            return appearance.rawValue
        }
        set(index) {
            self.appearance = AppLabelAppearance(rawValue: index) ?? .normalWhite
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
        case .normalWhite:
            textColor = FlatWhite()
        case .titleWhite:
            textColor = FlatWhite()
            font = UIFont.boldSystemFont(ofSize: 17.0)
        case .normalBlue:
            textColor = FlatSkyBlue()
        case .titleBlue:
            textColor = FlatSkyBlue()
            font = UIFont.boldSystemFont(ofSize: 17.0)
        }
    }

}
