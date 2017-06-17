//
//  UIImageExtensionResize.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 4/6/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

extension UIImage {

    func resize(toWidth width: CGFloat) -> UIImage? {
        let scaleFactor = width / size.width
        let height = size.height * scaleFactor

        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
        draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }

}
