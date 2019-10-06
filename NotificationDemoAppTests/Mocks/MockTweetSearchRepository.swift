//
//  MockTweetSearchRepository.swift
//  NotificationDemoAppTests
//
//  Created by Margarita Blanc on 04/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//
@testable import NotificationDemoApp
import Foundation

final class MockTweetSearchRepository : TweetSearchRepositoryType {

    
    var tweetItem: [TweetItem]?
    var trueFalse: Bool?
    
    func checkIfFavorite(hashtagArray: [String], completion: (([TweetItem]) -> Void)) {
        if let tweets = tweetItem {
            completion(tweets)
        }
        if tweetItem == nil {completion([])}
    }
    
    func getTweets(hashTag: String, success: @escaping (Result<[TweetItem]>) -> Void, onError: @escaping (String) -> Void) {
        if let tweets = tweetItem {
            success(.success(value: tweets))
        } else {
            success(.error)
            onError("Error Returned")
        }
    }
    
    func getTweets(hashTag: String, latitude: String, longitude: String, success: @escaping (Result<[TweetItem]>) -> Void, onError: @escaping (String) -> Void) {
        if let tweets = tweetItem {
            success(.success(value: tweets))
        } else {
            success(.error)
            onError("Error Returned")
        }
    }
    
    func getSavedTweet(completion: @escaping (Result<[TweetItem]>) -> Void) {
        if let tweets = tweetItem {
            completion(.success(value: tweets))
        }
        else {
            completion(.error)
        }
    }
}
