//
//  UserDAORest.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 7/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserDAORest: UserDAO {

    var parseUser = { (json: JSON) throws -> User in
        guard let userID = json["id"].int, let username = json["username"].string else {
                throw ParseError.entityFieldNotFound
        }
        let avatarURL = json["avatarURL"].string
        return User(userID: userID, username: username, avatarURL: avatarURL)
    }

    func loginWith(username: String, password: String, successCallback: @escaping (User) -> Void,
                   errorCallback: @escaping (String) -> Void) {
        let parameters: Parameters = [
            "username": username,
            "password": password
        ]

        Alamofire.request("http://localhost:8080/MoviesAppRest/rest/user/login", method: .post, parameters: parameters,
            encoding: JSONEncoding.default).validate(statusCode: 200...200).responseJSON { [unowned self] response in
                switch response.result {
                case .success(let value):
                    do {
                        let jsonResponse = try ResponseParser<User>().parse(value: value, entityParser: self.parseUser)
                        if jsonResponse.status == "OK", let user = jsonResponse.object {
                            successCallback(user)
                        } else if jsonResponse.status == "ERROR" {
                            errorCallback(jsonResponse.message)
                        } else {
                            errorCallback("There has been a problem with the service. Try again later.")
                        }
                    } catch {
                        errorCallback("There has been a problem with the service. Try again later.")
                    }
                case .failure:
                    errorCallback("There has been a problem with the service. Try again later.")
                }
        }
    }

    func registerWith(username: String, password: String, successCallback: @escaping (User) -> Void,
                      errorCallback: @escaping (String) -> Void) {
        let parameters: Parameters = [
            "username": username,
            "password": password
        ]

        Alamofire.request("http://localhost:8080/MoviesAppRest/rest/user/register", method: .post,
            parameters: parameters, encoding: JSONEncoding.default).validate(statusCode: 200...200)
            .responseJSON { [unowned self] response in
                switch response.result {
                case .success(let value):
                    do {
                        let jsonResponse = try ResponseParser<User>().parse(value: value, entityParser: self.parseUser)
                        if jsonResponse.status == "OK", let user = jsonResponse.object {
                            successCallback(user)
                        } else if jsonResponse.status == "ERROR" {
                            errorCallback(jsonResponse.message)
                        } else {
                            errorCallback("There has been a problem with the service. Try again later.")
                        }
                    } catch {
                        errorCallback("There has been a problem with the service. Try again later.")
                    }
                case .failure:
                    errorCallback("There has been a problem with the service. Try again later.")
                }
        }
    }

}
