//
//  ResponseParser.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 9/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation
import SwiftyJSON

class ResponseParser<T> {

    typealias EntityParser = (JSON) throws -> T

    func parse(value: Any, entityParser: EntityParser?) throws -> Response<T> {
        let json = JSON(value)
        if let status = json["status"].string, let message = json["message"].string {
            let responseStatus = ResponseStatus(rawValue: status) ?? .error
            var entity: T? = nil
            if responseStatus == .ok {
                let data = json["data"]
                do {
                    entity = try entityParser?(data)
                } catch {
                    throw error
                }
            }
            let response = Response<T>(status: responseStatus, message: message, object: entity)
            return response
        }
        throw ParseError.responseFieldNotFound
    }

}
