//
//  MockTweetDetailRepository.swift
//  NotificationDemoAppTests
//
//  Created by Margarita Blanc on 04/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

@testable import NotificationDemoApp
import Foundation

final class MockTweetDetailRepository: TweetDetailRepositoryType {
    
    var state: Bool? = nil
    
    func saveTweet(tweet: TweetItem) {
    }
    
    func removeFavorite(tweetID: String) {
    }
    
    func checkIfFavorite(tweetID: String, completion: (Bool) -> Void) {
        if state != nil {
            completion(state!)
        }
        else {
            completion(false)
        }
    }
}
