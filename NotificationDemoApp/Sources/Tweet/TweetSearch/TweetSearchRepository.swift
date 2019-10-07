//
//  TwiiterSearchRepository.swift
//  NotificationDemoApp
//
//  Created by Margarita Blanc on 29/09/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation
import CoreData

    // MARK - Protocols

protocol TweetSearchRepositoryType {
    func getTweets(hashTag: String, success: @escaping (Result<[TweetItem]>) -> Void, onError: @escaping (String) -> Void)
    func getTweets(hashTag: String, latitude: String, longitude: String, success: @escaping (Result<[TweetItem]>) -> Void, onError: @escaping (String) -> Void)
    func getSavedTweet(completion: @escaping (Result<[TweetItem]>) -> Void)
    func checkIfFavorite(hashtagArray: [String], completion: (([TweetItem]) -> Void))
}

final class TweetSearchRepository: TweetSearchRepositoryType {
    
    // MARK - Properties
    
    private let network: NetworkType
    
    private let route = Route()
    
    // MARK - Init
    
    init(network: NetworkType) {
        self.network = network
    }
    
    // MARK - Public methods
    
    func checkIfFavorite(hashtagArray: [String], completion: ([TweetItem]) -> Void) {
        
        var predicateList: [TweetObject] = []
        
        for hashtag in hashtagArray{
            let request: NSFetchRequest<TweetObject> = TweetObject.fetchRequest()
            request.predicate = NSPredicate(format: "message CONTAINS[c] %@", hashtag)
            request.sortDescriptors = [NSSortDescriptor(keyPath: \TweetObject.id, ascending: true)]
            
            guard let tweet = try? AppDelegate.viewContext.fetch(request) else {break}
            
            predicateList.append(contentsOf: tweet)
        }
        
        if predicateList == [] {completion([]);return}
        
        let tweets: [TweetItem] = predicateList.map{return TweetItem(message: $0.message ?? "", id: $0.id ?? "", date: $0.date ?? "", liked: $0.liked ?? "", retweet: $0.retweet ?? "", userName: $0.userName ?? "", userID: $0.userID ?? "", profilePicture: $0.profilePicture ?? "")}
        completion(tweets)
    }
    
    func getTweets(hashTag: String, success: @escaping (Result<[TweetItem]>) -> Void, onError: @escaping (String) -> Void) {
        
        guard let url = route.getUrl(hashtag: hashTag) else {return}
        network.requestTwitter(type: Tweet.self, url: url) { (result) in
            switch result {
            case .success(value: let foundTweets):
                let tweets: [TweetItem] = foundTweets.statuses.map{ return
                    TweetItem(message: $0.text, id: String($0.id), date: $0.created_at, liked: String($0.favorite_count), retweet: String($0.retweet_count), userName: $0.user.screen_name, userID: String($0.user.id), profilePicture: $0.user.profile_image_url_https )}
                success(.success(value: tweets))
                
            case .error:
                break
            }
        }
    }
    
    func getTweets(hashTag: String, latitude: String, longitude: String, success: @escaping (Result<[TweetItem]>) -> Void, onError: @escaping (String) -> Void) {
        
        guard let url = route.getUrl(hashtag: hashTag, latitude: latitude, longitude: longitude) else {return}
        network.requestTwitter(type: Tweet.self, url: url) { (result) in
            switch result {
            case .success(value: let foundTweets):
                let tweets: [TweetItem] = foundTweets.statuses.map{ return
                    TweetItem(message: $0.text, id: String($0.id), date: $0.created_at, liked: String($0.favorite_count), retweet: String($0.retweet_count), userName: $0.user.screen_name, userID: String($0.user.id), profilePicture: $0.user.profile_image_url_https)}
                success(.success(value: tweets))
                
            case .error:
                print("error")
            }
        }
    }
    
    func getSavedTweet(completion: @escaping (Result<[TweetItem]>) -> Void) {
        let request: NSFetchRequest<TweetObject> = TweetObject.fetchRequest()
        
        guard let tweets = try? AppDelegate.viewContext.fetch(request) else { return}
        let tweetObject : [TweetItem] = tweets.map  { return TweetItem(message: $0.message ?? "", id: $0.id ?? "", date: $0.date ?? "", liked: $0.liked ?? "", retweet: $0.retweet ?? "", userName: $0.userName ?? "", userID: $0.id ?? "", profilePicture: $0.profilePicture ?? "")
        }
        completion(.success(value: tweetObject))
    }
}

//extension TweetItem {
//    init(object: TweetObject) {
//        self.message = object.message, self.id = object.id, self.date = object.date, self.liked = object.liked, self.retweet = object.retweet, self.userName = object.userName, self.userID = object.id, self.
//    }
//}
////
//let object = TweetObject()
//let tweetItem = TweetItem(object: object)
//
//XCTAssertEqual(tweetItem.message, "coucou")

