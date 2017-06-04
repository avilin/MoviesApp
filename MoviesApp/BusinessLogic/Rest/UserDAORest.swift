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

    private let genericError = "There has been a problem with the service. Try again later."

    var parseUser = { (json: JSON) throws -> User in
        guard let userID = json["id"].int, let username = json["username"].string else {
                throw ParseError.entityFieldNotFound
        }
        let avatarURL = json["avatarURL"].string
        return User(userID: userID, username: username, avatarURL: avatarURL)
    }

    func loginWith(username: String, password: String, successCallback: @escaping (User) -> Void,
                   errorCallback: @escaping (ResponseStatus, String) -> Void) {

        Alamofire.request(RestRouter.login(username: username, password: password)).validate(statusCode: 200...200)
            .responseJSON { [unowned self] response in
                switch response.result {
                case .success(let value):
                    do {
                        let jsonResponse = try ResponseParser<User>().parse(value: value, entityParser: self.parseUser)
                        if jsonResponse.status == .ok, let user = jsonResponse.object {
                            successCallback(user)
                        } else if jsonResponse.status == .error {
                            errorCallback(jsonResponse.status, jsonResponse.message)
                        } else {
                            errorCallback(jsonResponse.status, self.genericError)
                        }
                    } catch {
                        errorCallback(.error, self.genericError)
                    }
                case .failure:
                    errorCallback(.error, self.genericError)
                }
        }
    }

    func registerWith(username: String, password: String, successCallback: @escaping (User) -> Void,
                      errorCallback: @escaping (ResponseStatus, String) -> Void) {

        Alamofire.request(RestRouter.register(username: username, password: password))
            .validate(statusCode: 200...200).responseJSON { [unowned self] response in
                switch response.result {
                case .success(let value):
                    do {
                        let jsonResponse = try ResponseParser<User>().parse(value: value, entityParser: self.parseUser)
                        if jsonResponse.status == .ok, let user = jsonResponse.object {
                            successCallback(user)
                        } else if jsonResponse.status == .error {
                            errorCallback(jsonResponse.status, jsonResponse.message)
                        } else {
                            errorCallback(jsonResponse.status, self.genericError)
                        }
                    } catch {
                        errorCallback(.error, self.genericError)
                    }
                case .failure:
                    errorCallback(.error, self.genericError)
                }
        }
    }

}
