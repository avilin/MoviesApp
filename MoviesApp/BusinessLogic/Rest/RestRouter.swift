//
//  UserRestRouter.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 3/6/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Alamofire

enum RestRouter: URLRequestConvertible {

    case login(username: String, password: String)
    case register(username: String, password: String)
    case findAllMovies
    case deleteMovie(movieID: Int)
    case createMovie(movie: Movie, user: User)

    private static let baseURLString = "http://localhost:8080/MoviesAppRest/rest"

    var method: HTTPMethod {
        switch self {
        case .login, .register, .createMovie:
            return .post
        case .findAllMovies:
            return .get
        case .deleteMovie:
            return .delete
        }
    }

    var path: String {
        switch self {
        case .login:
            return "/user/login"
        case .register:
            return "/user/register"
        case .findAllMovies, .createMovie:
            return "/movie"
        case .deleteMovie(let movieID):
            return "/movie/\(movieID)"
        }
    }

    // MARK: URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try RestRouter.baseURLString.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        switch self {
        case .login(let username, let password), .register(let username, let password):
            let parameters: Parameters = [
                "username": username,
                "password": password
            ]
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case .createMovie(let movie, let user):
            let parameters: Parameters = [
                "name": movie.name,
                "synopsis": movie.synopsis,
                "movieLength": movie.movieLength,
                "releaseDate": movie.releaseDate,
                "genre": movie.genre,
                "imageURL": movie.imageURL ?? "",
                "thumbnailImageURL": movie.thumbnailImageURL ?? "",
                "author": movie.author
            ]

            let plainString = "\(user.username):\(user.password)"
            let plainData = plainString.data(using: String.Encoding.utf8)
            let base64String = plainData?.base64EncodedString()

            if let base64String = base64String {
                urlRequest.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
            }

            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        default:
            break
        }

        return urlRequest
    }

}
