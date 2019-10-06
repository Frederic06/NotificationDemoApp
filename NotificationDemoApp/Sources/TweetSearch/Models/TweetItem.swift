//
//  Tweet.swift
//  NotificationDemoApp
//
//  Created by Margarita Blanc on 30/09/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

struct TweetItem: Equatable {
    let message: String
    let id: String
    let date: String
    let liked: String
    let retweet: String
    let userName: String
    let userID: String
    let profilePicture: String
    
    static func ==(lhs: TweetItem, rhs: TweetItem) -> Bool {
        return lhs.message == rhs.message && lhs.id == rhs.id && lhs.date == rhs.date && lhs.liked == rhs.liked && lhs.retweet == rhs.retweet && lhs.userName == rhs.userName && lhs.userID == rhs.userID && lhs.profilePicture == rhs.profilePicture
    }
}
