//
//  TweetCellViewModel.swift
//  NotificationDemoApp
//
//  Created by Margarita Blanc on 04/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

final class TweetCellViewModel {
    
    // MARK: - Properties

    private let index: Int
    
    private let tweet: TweetItem
    
    // MARK: - Initializer
    
    init(tweet: TweetItem, index: Int) {
        self.tweet = tweet
        self.index = index
    }
    
     // MARK: - Outputs
    
    var tweetMessage: ((String) -> Void)?
    
    var userImage: ((String) -> Void)?
    
    var userName: ((String) -> Void)?
    
    var liked: ((String) -> Void)?
    
    var tweetDate: ((String) -> Void)?
    
    var retweet: ((String) -> Void)?
   
    // MARK: - Public methods (Inputs)
    
    func configure() {
        tweetMessage?(tweet.message)
        userImage?(tweet.profilePicture)
        userName?(tweet.userName)
        liked?("♡ \(tweet.liked)")
        tweetDate?(tweet.date)
        retweet?("⮑ \(tweet.retweet)")
    }
}
