//
//  ViewStyler.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 30/4/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit
import ChameleonFramework

class ViewStyler {

    static func style(backgroudView view: UIView) {
        view.backgroundColor = FlatWhite()
    }

    static func style(formView view: UIView) {
        view.backgroundColor = FlatSkyBlue()
        view.layer.cornerRadius = 5
    }

    static func style(formButton button: UIButton) {
        button.backgroundColor = FlatWhite()
        button.setTitleColor(FlatSkyBlue(), for: .normal)
        button.layer.cornerRadius = 5
    }

}