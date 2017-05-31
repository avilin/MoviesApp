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

    var appButtonType: AppButtonType = .normal

    @IBInspectable var appButtonTypeAdapter: Int {
        get {
            return appButtonType.rawValue
        }
        set(index) {
            self.appButtonType = AppButtonType(rawValue: index) ?? .normal
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
        switch appButtonType {
        case .normal:
            setTitleColor(FlatWhite(), for: .normal)
        case .important:
            backgroundColor = FlatWhite()
            setTitleColor(FlatSkyBlue(), for: .normal)
        case .destructive:
            break
        }
        layer.cornerRadius = 5
    }

}

enum AppButtonType: Int {
    case normal
    case important
    case destructive
}
