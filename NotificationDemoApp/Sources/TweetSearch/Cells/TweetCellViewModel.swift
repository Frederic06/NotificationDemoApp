//
//  TweetCellViewModel.swift
//  NotificationDemoApp
//
//  Created by Margarita Blanc on 04/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

final class TweetCellViewModel {
    
    private let index: Int
//    private let tweetCoreText: String
//    private let userName: String
//    private let userPicture: String
//    private let tweetDate: String
//    private let liked: Int
//    private let retweet: Int
    private let tweet: TweetItem
    
    init(tweet: TweetItem, index: Int) {
        self.tweet = tweet
        self.index = index
    }
}
