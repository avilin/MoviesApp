//
//  AppDelegate.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 29/4/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initApplication()
        return true
    }

    func initApplication() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let sceneAssembler = SceneAssembler()
        let sceneRouter = SceneRouter(sceneAssembler: sceneAssembler)
        sceneRouter.showLogin(window: window!)
    }

}
