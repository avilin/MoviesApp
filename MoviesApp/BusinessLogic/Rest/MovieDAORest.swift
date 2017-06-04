//
//  MovieDAORest.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 27/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MovieDAORest: MovieDAO {

    var parseMovies = { (json: JSON) throws -> [Movie] in
        var movies: [Movie] = []

        guard let jsonArray = json.array else {
            throw ParseError.entityFieldNotFound
        }

        for movieJSON in jsonArray {
            guard let movieID = movieJSON["id"].int, let name = movieJSON["name"].string,
                let synopsis = movieJSON["synopsis"].string, let movieLength = movieJSON["movieLength"].int,
                let releaseDate = movieJSON["releaseDate"].int, let genre = movieJSON["genre"].string,
                let author = movieJSON["author"].int else {

                throw ParseError.entityFieldNotFound
            }
            let imageURL = movieJSON["imageURL"].string
            let thumbnailImageURL = movieJSON["thumbnailImageURL"].string

            let movie = Movie(movieID: movieID, name: name, synopsis: synopsis, movieLength: movieLength,
                releaseDate: releaseDate, genre: genre, imageURL: imageURL, thumbnailImageURL: thumbnailImageURL,
                author: author)
            movies.append(movie)
        }
        return movies
    }

    func findAll(successCallback: @escaping ([Movie]) -> Void,
                 errorCallback: @escaping (ResponseStatus, String) -> Void) {

        Alamofire.request(RestRouter.findAllMovies).validate(statusCode: 200...200)
            .responseJSON { [unowned self] response in
                switch response.result {
                case .success(let value):
                    do {
                        let jsonResponse = try ResponseParser<[Movie]>().parse(value: value,
                                                                               entityParser: self.parseMovies)
                        if jsonResponse.status == .ok, let movies = jsonResponse.object {
                            successCallback(movies)
                        } else if jsonResponse.status == .error {
                            errorCallback(jsonResponse.status, jsonResponse.message)
                        } else {
                            errorCallback(jsonResponse.status,
                                          "There has been a problem with the service. Try again later.")
                        }
                    } catch {
                        errorCallback(.error, "There has been a problem with the service. Try again later.")
                    }
                case .failure:
                    errorCallback(.error, "There has been a problem with the service. Try again later.")
                }
        }
    }

    func delete(movieID: Int, successCallback: @escaping () -> Void,
                errorCallback: @escaping (ResponseStatus, String) -> Void) {

        Alamofire.request(RestRouter.deleteMovie(movieID: movieID)).validate(statusCode: 200...200)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    do {
                        let jsonResponse = try ResponseParser<Any>().parse(value: value, entityParser: nil)
                        if jsonResponse.status == .ok {
                            successCallback()
                        } else if jsonResponse.status == .error {
                            errorCallback(jsonResponse.status, jsonResponse.message)
                        } else {
                            errorCallback(jsonResponse.status,
                                          "There has been a problem with the service. Try again later.")
                        }
                    } catch {
                        errorCallback(.error, "There has been a problem with the service. Try again later.")
                    }
                case .failure:
                    errorCallback(.error, "There has been a problem with the service. Try again later.")
                }
        }
    }

    func create(movie: Movie, user: User, successCallback: @escaping (Int) -> Void,
                errorCallback: @escaping (ResponseStatus, String) -> Void) {

        Alamofire.request(RestRouter.createMovie(movie: movie, user: user)).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    do {
                        let jsonResponse = try ResponseParser<Int>().parse(value: value) { (json) -> Int in
                            guard let movieID = json["id"].int else {
                                throw ParseError.entityFieldNotFound
                            }
                            return movieID
                        }
                        if jsonResponse.status == .ok, let movieID = jsonResponse.object {
                            successCallback(movieID)
                        } else if jsonResponse.status == .error {
                            errorCallback(jsonResponse.status, jsonResponse.message)
                        } else {
                            errorCallback(jsonResponse.status,
                                          "There has been a problem with the service. Try again later.")
                        }
                    } catch {
                        errorCallback(.error, "There has been a problem with the service. Try again later.")
                    }
                case .failure:
                    if response.response?.statusCode == 401 {
                        errorCallback(.unauthorized, "There has been a problem with the service. Try again later.")
                    } else {
                        errorCallback(.error, "There has been a problem with the service. Try again later.")
                    }
                }
        }
    }

}
