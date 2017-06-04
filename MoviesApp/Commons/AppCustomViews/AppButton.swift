//
//  AppButton.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 29/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit
import ChameleonFramework

@IBDesignable
class AppButton: UIButton {

    var appearance: AppButtonAppearance = .normal

    @IBInspectable var appButtonAppearanceAdapter: Int {
        get {
            return appearance.rawValue
        }
        set(index) {
            self.appearance = AppButtonAppearance(rawValue: index) ?? .normal
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
        case .normal:
            setTitleColor(FlatWhite(), for: .normal)
        case .important:
            backgroundColor = FlatWhite()
            setTitleColor(FlatSkyBlue(), for: .normal)
        }
        layer.cornerRadius = 5
    }

}
