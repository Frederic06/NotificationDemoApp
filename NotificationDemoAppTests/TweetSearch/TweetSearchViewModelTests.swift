//
//  TweetSearchViewModelTests.swift
//  NotificationDemoAppTests
//
//  Created by Margarita Blanc on 04/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import XCTest
@testable import NotificationDemoApp

final class TweetSearchViewModelTests: XCTestCase {

    func testGivenATweetSearchViewModel_WhenViewDidAppear_ThenPropertiesAreCorrectlyReturned() {
        let delegate = MockTweetSearchViewModelDelagte()
        let repository = MockTweetSearchRepository()
        let viewModel = TweetSearchViewModel(persistence: .favorite, delegate: delegate, repository: repository)
        
        let expectation1 = self.expectation(description: "returned searchPlaceHolder")
        let expectation2 = self.expectation(description: "returned switchState")

        
        viewModel.searchPlaceHolder = { text in
            XCTAssertEqual(text, "Type a hashtag here 👊")
            expectation1.fulfill()
        }
        
        viewModel.switchState = { status in
            XCTAssertEqual(status, false)
            expectation2.fulfill()
        }
        
        viewModel.viewDidAppear()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
        func testGivenATweetSearchViewModelAndRepositoryWithData_WhenViewDidAppear_ThenPropertiesAreCorrectlyReturned() {
            let delegate = MockTweetSearchViewModelDelagte()
            let repository = MockTweetSearchRepository()
            let tweetItem = TweetItem(message: "Voici un tweet test", id: "123456789", date: "30/09/1985", liked: "220", retweet: "30", userName: "The test profile", userID: "99887766554433221100", profilePicture: "https///profilePicture.png")
            repository.tweetItem = [tweetItem]
            
            let expectedResult = tweetItem
            
            let viewModel = TweetSearchViewModel(persistence: .search, delegate: delegate, repository: repository)
            
            let expectaction1 = self.expectation(description: "returned hashtagLabel")
            let expectaction2 = self.expectation(description: "returned tweets")
            
            viewModel.hashtagLabel = { label in
                XCTAssertEqual(label, "toto")
                expectaction1.fulfill()
            }
            
            viewModel.tweets = { tweet in
                XCTAssertEqual(tweet[0], expectedResult)
                expectaction2.fulfill()
            }
            
            
            viewModel.viewDidAppear()
            viewModel.updateAuthorization(status: .authorized)
            viewModel.updateCoordinates(latitude: 32332, longitude: 4311231)
            viewModel.selectLocation()
            viewModel.didWriteHashtag(text: "toto")
            
            waitForExpectations(timeout: 1.0, handler: nil)
    }
    
        func testGivenATweetSearchViewModelAndRepositoryWithDataThenPropertiesAreCorrectlyReturned() {
            let delegate = MockTweetSearchViewModelDelagte()
            let repository = MockTweetSearchRepository()
            let tweetItem = TweetItem(message: "Voici un tweet test", id: "123456789", date: "30/09/1985", liked: "220", retweet: "30", userName: "The test profile", userID: "99887766554433221100", profilePicture: "https///profilePicture.png")
            repository.tweetItem = [tweetItem]
            
            let expectedResult = tweetItem
            
            let viewModel = TweetSearchViewModel(persistence: .search, delegate: delegate, repository: repository)
            
            let expectaction1 = self.expectation(description: "returned hashtagLabel")
            let expectaction2 = self.expectation(description: "returned tweets")
            
            viewModel.hashtagLabel = { label in
                XCTAssertEqual(label, "toto")
                expectaction1.fulfill()
            }
            
            viewModel.tweets = { tweet in
                XCTAssertEqual(tweet[0], expectedResult)
                expectaction2.fulfill()
            }
            
            
            viewModel.viewDidAppear()
            viewModel.updateAuthorization(status: .denied)
            viewModel.didWriteHashtag(text: "toto")
            
            waitForExpectations(timeout: 1.0, handler: nil)
    }
    
        func testGivenATweetSearchViewModelWithPersistanceAndRepositoryWithDataThenPropertiesAreCorrectlyReturned() {
            let delegate = MockTweetSearchViewModelDelagte()
            let repository = MockTweetSearchRepository()
            let tweetItem = TweetItem(message: "Voici un tweet test", id: "123456789", date: "30/09/1985", liked: "220", retweet: "30", userName: "The test profile", userID: "99887766554433221100", profilePicture: "https///profilePicture.png")
            repository.tweetItem = [tweetItem]
            
            let expectedResult = tweetItem
            
            let viewModel = TweetSearchViewModel(persistence: .favorite, delegate: delegate, repository: repository)
            
            let expectaction1 = self.expectation(description: "returned tweets")
            
            viewModel.tweets = { tweet in
                XCTAssertEqual(tweet[0], expectedResult)
                expectaction1.fulfill()
            }
            
            
            viewModel.viewDidAppear()
            
            waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenViewModel_noData_CorrectlyAlertReturned() {
        let delegate = MockTweetSearchViewModelDelagte()
                    let repository = MockTweetSearchRepository()
                    let tweetItem = TweetItem(message: "Voici un tweet test", id: "123456789", date: "30/09/1985", liked: "220", retweet: "30", userName: "The test profile", userID: "99887766554433221100", profilePicture: "https///profilePicture.png")
                    repository.tweetItem = [tweetItem]
        
                    
                    let viewModel = TweetSearchViewModel(persistence: .favorite, delegate: delegate, repository: repository)
                    viewModel.viewDidAppear()
        viewModel.updateAuthorization(status: .denied)
        viewModel.selectLocation()
                    
                    let expectaction1 = self.expectation(description: "returned tweets")
        //            let expectaction2 = self.expectation(description: "returned displayAlert")
                    
        XCTAssertEqual(delegate.alertType, AlertType.noCoordinates)
        expectaction1.fulfill()
                    
                    
                    viewModel.viewDidAppear()
        viewModel.updateAuthorization(status: .denied)
        viewModel.selectLocation()
                    
                    waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenViewModel_data_DelegateIsCalled() {
        let delegate = MockTweetSearchViewModelDelagte()
        let repository = MockTweetSearchRepository()
        let tweetItem = TweetItem(message: "Voici un tweet test", id: "123456789", date: "30/09/1985", liked: "220", retweet: "30", userName: "The test profile", userID: "99887766554433221100", profilePicture: "https///profilePicture.png")
        
        let expectedResult = tweetItem
        
        let viewModel = TweetSearchViewModel(persistence: .favorite, delegate: delegate, repository: repository)
                viewModel.didSelectTweet(tweet: tweetItem)
        
        let expectaction1 = self.expectation(description: "returned didSelectTweet")
        
        XCTAssertEqual(delegate.tweetItem, expectedResult)
        expectaction1.fulfill()
        
        viewModel.didSelectTweet(tweet: tweetItem)
        
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testGivenViewModel_data_UnselectLocation() {
        let delegate = MockTweetSearchViewModelDelagte()
        let repository = MockTweetSearchRepository()
        let tweetItem = TweetItem(message: "Voici un tweet test", id: "123456789", date: "30/09/1985", liked: "220", retweet: "30", userName: "The test profile", userID: "99887766554433221100", profilePicture: "https///profilePicture.png")
        repository.tweetItem = [tweetItem]
        
        let viewModel = TweetSearchViewModel(persistence: .search, delegate: delegate, repository: repository)

        let expectaction1 = self.expectation(description: "returned switchState")
        
        viewModel.switchState = { state in
            XCTAssertEqual(state, false)
            expectaction1.fulfill()
        }
        
        viewModel.unSelectLocation()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenViewModel_noData_AlertCorrectlyAlertReturned() {
        let delegate = MockTweetSearchViewModelDelagte()
                    let repository = MockTweetSearchRepository()
                    
                    let viewModel = TweetSearchViewModel(persistence: .favorite, delegate: delegate, repository: repository)
                    viewModel.viewDidAppear()
        viewModel.updateAuthorization(status: .authorized)
        viewModel.selectLocation()
                    
                    let expectaction1 = self.expectation(description: "returned Alert NoCoordinates")
        //            let expectaction2 = self.expectation(description: "returned displayAlert")
                    
        XCTAssertEqual(delegate.alertType, AlertType.noCoordinates)
        expectaction1.fulfill()
                    
                    
                    viewModel.viewDidAppear()
        viewModel.selectLocation()
                    
                    waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenViewModel_onlyLatitude_CheckCoordinatesFalse() {
        let delegate = MockTweetSearchViewModelDelagte()
                    let repository = MockTweetSearchRepository()
                    
                    let viewModel = TweetSearchViewModel(persistence: .search, delegate: delegate, repository: repository)
                    
                    
                    let expectaction1 = self.expectation(description: "returned AlertType.networkError")
                    

                    
                    viewModel.viewDidAppear()
        viewModel.didWriteHashtag(text: "toto")
                    viewModel.updateAuthorization(status: .authorized)
        viewModel.updateCoordinates(latitude: 1221212, longitude: 123123123)
                    viewModel.selectLocation()
        
        XCTAssertEqual(delegate.alertType, AlertType.networkError)
        expectaction1.fulfill()
                    
                    waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenViewModel_nodata_CheckerrorRepository() {
        let delegate = MockTweetSearchViewModelDelagte()
                    let repository = MockTweetSearchRepository()
                    
                    let viewModel = TweetSearchViewModel(persistence: .search, delegate: delegate, repository: repository)
                    
                    
                    let expectaction1 = self.expectation(description: "returned AlertType.networkError")

                    
                    viewModel.viewDidAppear()
        viewModel.didWriteHashtag(text: "toto")
                    viewModel.updateAuthorization(status: .denied)
                    viewModel.unSelectLocation()
                    
        XCTAssertEqual(delegate.alertType, AlertType.networkError)

        expectaction1.fulfill()
                    
                    waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenViewModel_nodata_GetSavedTweetsCorrectlyErroReturned() {
        let delegate = MockTweetSearchViewModelDelagte()
                    let repository = MockTweetSearchRepository()
                    
                    let viewModel = TweetSearchViewModel(persistence: .favorite, delegate: delegate, repository: repository)
                    
                    
                    let expectaction1 = self.expectation(description: "returned AlertType.networkError")

                    
                    viewModel.viewDidAppear()
                    
        XCTAssertEqual(delegate.alertType, AlertType.networkError)

        expectaction1.fulfill()
                    
                    waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenViewModel_nodata_CheckIfSavedMatch() {
        let delegate = MockTweetSearchViewModelDelagte()
                    let repository = MockTweetSearchRepository()
                    
                    let viewModel = TweetSearchViewModel(persistence: .favorite, delegate: delegate, repository: repository)
                    
                    
                    let expectaction1 = self.expectation(description: "returned AlertType.noTweet")

                    
                    viewModel.viewDidAppear()
        viewModel.didWriteHashtag(text: "toto")
                    
        XCTAssertEqual(delegate.alertType, AlertType.noTweet)

        expectaction1.fulfill()
                    
                    waitForExpectations(timeout: 1.0, handler: nil)
    }
}

fileprivate final class MockTweetSearchViewModelDelagte: TweetSearcViewModelDelegate {
    
    var tweetItem: TweetItem?
    var alertType: AlertType?
    
    func displayAlert(type: AlertType) {
        self.alertType = type
    }
    
    func didPresstweet(tweet: TweetItem) {
        self.tweetItem = tweet
    }
}

