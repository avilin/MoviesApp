//
//  ImageUploadRest.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 4/6/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ImageUploadRest {

    private static let genericError = "There has been a problem uploading the image. Try again later."
    private static let baseURL = "http://uploads.im/api"

    static func uploadImageData(imageData: Data, successCallback: @escaping (String, String) -> Void,
                                errorCallback: @escaping (ResponseStatus, String) -> Void) {

        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image", fileName: "image.png", mimeType: "image/png")
        }, to: baseURL, encodingCompletion: { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })

                upload.responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        if let imageURL = json["data"]["img_url"].string,
                            let thumbnailImageURL = json["data"]["thumb_url"].string {

                            successCallback(imageURL, thumbnailImageURL)
                        } else {
                            errorCallback(.error, genericError)                        }
                    case .failure:
                        errorCallback(.error, genericError)
                    }
                }
            case .failure:
                errorCallback(.error, genericError)
            }
        })
    }

    static func uploadImageURL(imageURL: String, successCallback: @escaping (String, String) -> Void,
                               errorCallback: @escaping (ResponseStatus, String) -> Void) {

        let parameters: Parameters = ["upload": imageURL]

        Alamofire.request(baseURL, parameters: parameters).validate(statusCode: 200...200)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    if let imageURL = json["data"]["img_url"].string,
                        let thumbnailImageURL = json["data"]["thumb_url"].string {

                        successCallback(imageURL, thumbnailImageURL)
                    } else {
                        errorCallback(.error, genericError)
                    }
                case .failure:
                    errorCallback(.error, genericError)
                }
        }
    }

}
