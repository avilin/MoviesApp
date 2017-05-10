//
//  ActivityIndicatorHelper.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 10/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit
import ChameleonFramework

class ActivityIndicatorHelper {

    private let container = UIView()

    func createActivityIndicator(in view: UIView) {
        container.frame = view.frame
        container.center = view.center
        container.backgroundColor = FlatWhite().withAlphaComponent(0.3)

        let loadingView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = view.center
        loadingView.backgroundColor = FlatGrayDark().withAlphaComponent(0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10

        let actInd = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        actInd.activityIndicatorViewStyle = .whiteLarge
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        container.isHidden = true
        view.addSubview(container)
        actInd.startAnimating()
    }

    func showActivityIndicator() {
        container.isHidden = false
    }

    func hideActivityIndicator() {
        container.isHidden = true
    }
}
