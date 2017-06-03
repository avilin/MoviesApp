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

    var appLabelType: AppLabelType = .normalLight

    @IBInspectable var appLabelTypeAdapter: Int {
        get {
            return appLabelType.rawValue
        }
        set(index) {
            self.appLabelType = AppLabelType(rawValue: index) ?? .normalLight
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
        switch appLabelType {
        case .normalLight:
            textColor = FlatWhite()
        case .titleLight:
            textColor = FlatWhite()
            font = UIFont.boldSystemFont(ofSize: 17.0)
        }
    }

}

enum AppLabelType: Int {
    case normalLight
    case titleLight
}
