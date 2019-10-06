//
//  Network.swift
//  NotificationDemoApp
//
//  Created by Margarita Blanc on 01/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit
import Alamofire

protocol NetworkType {
    func authenticate(callback: @escaping ((String) -> Void))
    func requestTwitter<T>(type: T.Type, url: URL, completion: @escaping (Result<T>) -> Void) where T : Decodable
}

enum Result<T> {
    case success(value: T)
    case error
}

enum NetworkError: Error {
    case unknown
}

class Network: NetworkType {

    let consumerKey = "QgJjXz0ZvzmAWr2L7AR7LlBjC"
    let consumerSecret = "FA7u2SWNT02nQ8GGOTWU1GFFjFZb4aTMbRnERmOW8paQx1UNct"
    let authUrl = "https://api.twitter.com/oauth2/token"

    let jsonDecoder = JSONDecoder()

    func authenticate(callback: @escaping ((String) -> Void)){
        let credentials = "\(consumerKey):\(consumerSecret)"
        let encodedCredentials = credentials.toBase64()
        let params: [String: Any] = ["grant_type": "client_credentials"]
        let headers = ["Authorization":"Basic \(encodedCredentials)"]
        
        Alamofire.request("https://api.twitter.com/oauth2/token", method: .post, parameters: params, headers: headers)
            .responseJSON { response in
                guard let data = response.data else {return}
                guard let code = try? self.jsonDecoder.decode(BearerToken.self, from: data) else {return}
                callback(code.access_token)
        }
    }
    
    func requestTwitter<T>(type: T.Type, url: URL, completion: @escaping (Result<T>) -> Void) where T : Decodable {
        
        authenticate { (accessToken) in
            let headers = ["Authorization": "Bearer \(accessToken)"]
            
            Alamofire.request(url, method: .get, headers: headers).responseJSON { response in
                if response.error != nil {
                    completion(.error)
                } else if let data = response.data {
                    guard let tweets = try? self.jsonDecoder.decode(T.self, from: data) else {return}
                    completion(.success(value: tweets))
                } else {
                    completion(.error)
                }
            }
        }
    }
}
