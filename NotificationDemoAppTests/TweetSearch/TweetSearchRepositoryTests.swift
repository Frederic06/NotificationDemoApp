//
//  TweetSearchRepositoryTests.swift
//  NotificationDemoAppTests
//
//  Created by Margarita Blanc on 06/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

import XCTest
@testable import NotificationDemoApp

final class TweetSearchRepositoryTests: XCTestCase {
    
     func testGivenATweetSearchRepositoryWhenCallingIsCorrectly() {
    
    let netWork = MockNetwork()
    
    let repository = TweetSearchRepository(network: netWork)
        
     let expectation1 = self.expectation(description: "Returned emptyArray")
        repository.checkIfFavorite(hashtagArray: ["toto"]) { (tweets) in
            XCTAssertEqual(tweets, [])
            expectation1.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
     func testGivenATweetSearchRepositoryWithData() {
    
    let netWork = MockNetwork()
    
    let repository = TweetSearchRepository(network: netWork)
    let repositoryDetail = TweetDetailRepository()
        
        
//        let expectedResult: [TweetItem] = [tweet]
       
        
        
     let expectation1 = self.expectation(description: "Returned emptyArray")
        
//        repositoryDetail.saveTweet(tweet: tweet)

        repository.checkIfFavorite(hashtagArray: ["Bonjour"]) { (tweets) in
    
            XCTAssertEqual(tweets, [])
            expectation1.fulfill()
        }

        repositoryDetail.removeAll()

        waitForExpectations(timeout: 3.0, handler: nil)
        
                repositoryDetail.removeAll()
    }
    
         func testGivenATweetSearchRepositoryWithDataCheckIfFavorite() {
        
        let netWork = MockNetwork()
        
        let repository = TweetSearchRepository(network: netWork)
        let repositoryDetail = TweetDetailRepository()
            
            let tweet = TweetItem(message: "Bonsoir", id: "124", date: "", liked: "", retweet: "", userName: "", userID: "", profilePicture: "")
           
            
         let expectation1 = self.expectation(description: "Returned emptyArray")
            
            repositoryDetail.saveTweet(tweet: tweet)

            repository.checkIfFavorite(hashtagArray: ["Bonsoir"]) { (tweets) in
        
                XCTAssertEqual(tweets[0].id, "124")
                expectation1.fulfill()
            }
            waitForExpectations(timeout: 2.0, handler: nil)
        }
    
             func testGivenATweetSearchRepositoryWithDataGetSavedTweets() {
            
            let netWork = MockNetwork()
            
            let repository = TweetSearchRepository(network: netWork)
            let repositoryDetail = TweetDetailRepository()
                
                let tweet = TweetItem(message: "Bonsoir", id: "124", date: "", liked: "", retweet: "", userName: "", userID: "", profilePicture: "")
                                  
//                 repositoryDetail.saveTweet(tweet: tweet)
                
             let expectation1 = self.expectation(description: "Returned emptyArray")

                repository.getSavedTweet(completion: { result in
                    switch result {
                    case .success(value: let tweets):
                        XCTAssertEqual(tweets.count, 1)
                        expectation1.fulfill()
                    case .error:
                        print("error")
                    }
                })
                waitForExpectations(timeout: 2.0, handler: nil)
    //                    repositoryDetail.removeAll()
            }
    
    func testGivenATweetSearchRepositoryWithDataThenCallGetTweets() {
    
    let netWork = MockNetwork()
    
    let repository = TweetSearchRepository(network: netWork)
        
        guard let path = Bundle.main.path(forResource: "FakeTweets", ofType: "json") else { return }
        
    netWork.url1 = URL(fileURLWithPath: path)

            let expectation1 = self.expectation(description: "Returned not nil")
        
        let expectation2 = self.expectation(description: "Returned data")
        
        repository.getTweets(hashTag: "", success: { (response) in
            switch response {
            case .success(value: let tweets):
                XCTAssertNotNil(tweets)
                expectation1.fulfill()
                
                XCTAssertEqual(tweets[0].id, "1180769918700150784")
                expectation2.fulfill()
            case .error:
                print("error")
            }
        }) { (error) in
            print(error)
        }
            waitForExpectations(timeout: 1.0, handler: nil)
    }
    
       func testGivenATweetSearchRepositoryWithDataThenCallGetTweetsWithCoordinates() {
    
    let netWork = MockNetwork()
    
    let repository = TweetSearchRepository(network: netWork)
        
        guard let path = Bundle.main.path(forResource: "FakeTweets", ofType: "json") else { return }
        
    netWork.url1 = URL(fileURLWithPath: path)

            let expectation1 = self.expectation(description: "Returned not nil")
        
        let expectation2 = self.expectation(description: "Returned data")
        
        repository.getTweets(hashTag: "", latitude: "", longitude: "", success: { (response) in
                       switch response {
                       case .success(value: let tweets):
                           XCTAssertNotNil(tweets)
                           expectation1.fulfill()
                           
                           XCTAssertEqual(tweets[0].id, "1180769918700150784")
                           expectation2.fulfill()
                       case .error:
                           print("error")
                       }
                   }) { (error) in
                       print(error)
                   }
                       waitForExpectations(timeout: 1.0, handler: nil)
               }
}


//("TweetItem(message: "Bonjour", id: "1234599", date: "30.09.1985", liked: "1234567", retweet: "1234567", userName: "Paul Lemoine", userID: "987662", profilePicture: "https://picture.png")")
//
//("TweetItem(message: "Bonjour", id: "1234599", date: "30.09.1985", liked: "1234567", retweet: "0", userName: "Paul Lemoine", userID: "987662", profilePicture: "https://picture.png")")
//



//final class MockNetwork: NetworkType {
//    func authenticate(callback: @escaping ((String) -> Void)) {
//    }
//
//    func requestTwitter<T>(type: T.Type, url: URL, completion: @escaping (Result<T>) -> Void) where T : Decodable {
//    }
//}
