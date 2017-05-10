//
//  SceneRouter.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 30/4/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class SceneRouter {

    private let window: UIWindow
    private let sceneAssembler: SceneAssembler

    init(window: UIWindow, sceneAssembler: SceneAssembler) {
        self.window = window
        self.sceneAssembler = sceneAssembler
    }

    func showLogin() {
        window.rootViewController = sceneAssembler.assembleLogin(sceneRouter: self)
        window.makeKeyAndVisible()
    }

    func showMovieCollection() {
        window.rootViewController = sceneAssembler.assembleMovieCollection()
        window.makeKeyAndVisible()
    }
}
