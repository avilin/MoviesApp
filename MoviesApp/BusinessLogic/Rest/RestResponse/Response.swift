//
//  Response.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 8/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import SwiftyJSON

class Response<T> {

    let status: ResponseStatus
    let message: String
    let object: T?

    init(status: ResponseStatus, message: String, object: T?) {
        self.status = status
        self.message = message
        self.object = object
    }

}
