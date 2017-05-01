//
//  SceneRouter.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 30/4/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class SceneRouter {

    let sceneAssembler: SceneAssembler

    init(sceneAssembler: SceneAssembler) {
        self.sceneAssembler = sceneAssembler
    }

    func showLogin(window: UIWindow) {
        window.rootViewController = sceneAssembler.assembleLogin()
        window.makeKeyAndVisible()
    }
}
