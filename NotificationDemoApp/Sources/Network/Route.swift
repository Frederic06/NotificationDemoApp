//
//  Route.swift
//  NotificationDemoApp
//
//  Created by Margarita Blanc on 01/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

class Route {
    
    private let baseUrl = "https://api.twitter.com/1.1/search/tweets.json?q="
    
    func getUrl(hashtag: String) -> URL? {
        let urlString = "https://api.twitter.com/1.1/search/tweets.json?q=\(hashtag)"
        guard let url = URL(string: urlString) else {return nil}
        return url
    }
    
    func getUrl(hashtag: String, latitude: String, longitude: String) -> URL? {
        let urlString = "https://api.twitter.com/1.1/search/tweets.json?q=\(hashtag)&geocode=\(latitude),\(longitude),100km"
        guard let url = URL(string: urlString) else {return nil}
        return url
    }
}
