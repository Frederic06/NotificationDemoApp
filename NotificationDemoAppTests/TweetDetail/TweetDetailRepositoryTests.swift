//
//  TweetDetailRepositoryTests.swift
//  NotificationDemoAppTests
//
//  Created by Margarita Blanc on 06/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

import XCTest
@testable import NotificationDemoApp

final class TweetDetailRepositoryTests: XCTestCase {
    
     func testGivenATweetSearchRepositoryWhenCallingIsCorrectly() {
    
        let tweet = TweetItem(message: "Bonne nuit", id: "12345", date: "Septembre", liked: "3", retweet: "2", userName: "Paulo", userID: "09876", profilePicture: "http://toto.png ")
    
    let repository = TweetDetailRepository()
        
     let expectation1 = self.expectation(description: "Returned checkIfFavorite")
        
         let expectation2 = self.expectation(description: "Returned Removed From Favorite")
       
        repository.saveTweet(tweet: tweet)
        
        repository.checkIfFavorite(tweetID: "12345") { (state) in
            XCTAssertEqual(state, true)
            expectation1.fulfill()
        }
        
        repository.removeFavorite(tweetID: "12345")
        
        repository.checkIfFavorite(tweetID: "12345") { (state) in
              XCTAssertEqual(state, false)
                      expectation2.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
        
        repository.removeAll()
    }
}
