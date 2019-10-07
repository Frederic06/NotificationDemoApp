//
//  TweetType.swift
//  NotificationDemoApp
//
//  Created by Margarita Blanc on 01/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

struct Tweet: Decodable {
    
    var statuses: [Statuses]
    
    struct Statuses: Decodable {
        var created_at: String
        var id: Int
        var text: String
        var user: User
        var favorite_count: Int
        var retweet_count: Int
    }
    
    struct User: Decodable {
        var id: Int
        var screen_name: String
        var profile_image_url_https: String
    }
}
