//
//  SceneAssembler.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 30/4/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class SceneAssembler {

    private let mainStoryboardName = "Main"
    private let loginIdentifier = "LoginViewController"

    func assembleLogin() -> UIViewController {
        let storyboad = UIStoryboard(name: mainStoryboardName, bundle: nil)
        let loginViewController = storyboad.instantiateViewController(withIdentifier: loginIdentifier)
        return loginViewController
    }

}
