//
//  TweetDetailViewModelTests.swift
//  NotificationDemoAppTests
//
//  Created by Margarita Blanc on 04/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import XCTest
@testable import NotificationDemoApp

final class TweetDetailViewModelTests: XCTestCase {

    func testGivenATweetSearchViewModel_WhenViewDidLoad_ThenPropertiesAreCorrectlyReturned() {
        
        let tweet: TweetItem = TweetItem(message: "Voici un tweet test", id: "123456789", date: "30/09/1985", liked: "220", retweet: "30", userName: "The test profile", userID: "99887766554433221100", profilePicture: "https///profilePicture.png")
        let repository = MockTweetDetailRepository()
        let viewModel = TweetDetailViewModel(delegate: self, repository: repository, tweet: tweet)
        
        let expectaction2 = self.expectation(description: "returned profilePictureString")
        
        let expectaction3 = self.expectation(description: "returned profileNameText")
        
        let expectaction4 = self.expectation(description: "returned AtweetDate")
        
        let expectaction5 = self.expectation(description: "returned tweetMessage")
        
        viewModel.profilePictureString = { url in
            XCTAssertEqual(url, "https///profilePicture.png")
            expectaction2.fulfill()
        }
        
        viewModel.profileNameText = { text in
            XCTAssertEqual(text, "The test profile")
            expectaction3.fulfill()
        }
        
        viewModel.tweetDate = { date in
            XCTAssertEqual(date, "30/09/1985")
            expectaction4.fulfill()
        }
        
        viewModel.tweetMessage = { text in
            XCTAssertEqual(text, "Voici un tweet test")
            expectaction5.fulfill()
        }
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
        
    }
    
    func testGivenATweetSearchViewModelGivenaRepository_WhenViewDidLoad_ThenPropertiesAreCorrectlyReturned() {
        let tweet: TweetItem = TweetItem(message: "Voici un tweet test", id: "123456789", date: "30/09/1985", liked: "220", retweet: "30", userName: "The test profile", userID: "99887766554433221100", profilePicture: "https///profilePicture.png")
        let repository = MockTweetDetailRepository()
        repository.state = true
        
        let viewModel = TweetDetailViewModel(delegate: self, repository: repository, tweet: tweet)
        
         let expectaction1 = self.expectation(description: "returned isFavorite")
        
        viewModel.savedButton = { state in
             XCTAssertEqual(state, true)
            expectaction1.fulfill()
        }
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenATweetSearchViewModelGivenaRepositoryFavoriteIsTrue_WhenViewDidLoad_ThenDidPressSave() {
        let tweet: TweetItem = TweetItem(message: "Voici un tweet test", id: "123456789", date: "30/09/1985", liked: "220", retweet: "30", userName: "The test profile", userID: "99887766554433221100", profilePicture: "https///profilePicture.png")
        let repository = MockTweetDetailRepository()
        repository.state = true
        let viewModel = TweetDetailViewModel(delegate: self, repository: repository, tweet: tweet)
        

        
         let expectaction1 = self.expectation(description: "returned isFavorite")
        
        viewModel.savedButton = { state in
             XCTAssertEqual(state, false)
            expectaction1.fulfill()
        }
        
        viewModel.didPressSave()
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testGivenATweetSearchViewModelGivenaRepositoryFavoriteIsFalse_WhenViewDidLoad_ThenDidPressSave() {
        let tweet: TweetItem = TweetItem(message: "Voici un tweet test", id: "123456789", date: "30/09/1985", liked: "220", retweet: "30", userName: "The test profile", userID: "99887766554433221100", profilePicture: "https///profilePicture.png")
        let repository = MockTweetDetailRepository()
        repository.state = false
        let viewModel = TweetDetailViewModel(delegate: self, repository: repository, tweet: tweet)
        

        
         let expectaction1 = self.expectation(description: "returned isFavorite")
        
        viewModel.savedButton = { state in
             XCTAssertEqual(state, true)
            expectaction1.fulfill()
        }
        
        viewModel.didPressSave()
        waitForExpectations(timeout: 2.0, handler: nil)
    }
}

extension TweetDetailViewModelTests: TweetDetailViewModelDelegate {
    func didPressFavorite(tweet: TweetItem) {
    }
    
    func displayAlarm(type: AlertType) {
    }
}

fileprivate final class MockTweetDetailDelegate: TweetDetailViewModelDelegate {
    func didPressFavorite(tweet: TweetItem) {
    }
    
    
    var tweetItem: TweetItem?
    var alertType: AlertType?
    
    func displayAlarm(type: AlertType) {
        self.alertType = type
    }
    
    func didPresstweet(tweet: TweetItem) {
        self.tweetItem = tweet
    }
}
