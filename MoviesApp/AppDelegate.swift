//
//  AppDelegate.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 29/4/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit
import ChameleonFramework

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

        UINavigationBar.appearance().backgroundColor = FlatWhite()
        UINavigationBar.appearance().tintColor = FlatSkyBlue()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: FlatSkyBlue()]

        let userDAO = UserDAORest()
        let userService = UserService(userDAO: userDAO)

        let movieDAO = MovieDAORest()
        let movieService = MovieService(movieDAO: movieDAO)

        let sceneAssembler = SceneAssembler(userService: userService, movieService: movieService)
        let sceneRouter = SceneRouter(window: window!, sceneAssembler: sceneAssembler)

        if userService.userLogged() {
            sceneRouter.showMovieCollection()
        } else {
            sceneRouter.showLogin()
        }
    }

}
