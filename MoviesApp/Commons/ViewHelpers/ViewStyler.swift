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
        view.backgroundColor = FlatSkyBlue()
    }

    static func style(navigationView view: UINavigationBar) {
        view.backgroundColor = FlatWhite()
        view.titleTextAttributes = [NSForegroundColorAttributeName: FlatSkyBlue()]
    }

    static func style(formMainButton button: UIButton) {
        button.backgroundColor = FlatWhite()
        button.setTitleColor(FlatSkyBlue(), for: .normal)
        button.layer.cornerRadius = 5
    }

    static func style(formButton button: UIButton) {
        button.setTitleColor(FlatWhite(), for: .normal)
    }

}
