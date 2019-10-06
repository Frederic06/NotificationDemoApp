//
//  TweetDetailRepository.swift
//  NotificationDemoApp
//
//  Created by Margarita Blanc on 03/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation
import CoreData

protocol TweetDetailRepositoryType {
    func saveTweet(tweet: TweetItem)
    func removeFavorite(tweetID: String)
    func checkIfFavorite(tweetID: String, completion: (Bool) -> Void)
}

final class TweetDetailRepository: TweetDetailRepositoryType {
    
    func saveTweet(tweet: TweetItem) {
        print(tweet)
        let tweetObject = TweetObject(context: AppDelegate.viewContext)
        tweetObject.date = tweet.date
        tweetObject.id = tweet.id
        tweetObject.liked = tweet.liked
        tweetObject.message = tweet.message
        tweetObject.profilePicture = tweet.profilePicture
        tweetObject.retweet = tweet.retweet
        tweetObject.userID = tweet.userID
        tweetObject.userName = tweet.userName
        try? AppDelegate.viewContext.save()
    }
    
    func removeFavorite(tweetID: String) {
        
            let request: NSFetchRequest<TweetObject> = TweetObject.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", tweetID)
            
        do {
            let object = try AppDelegate.viewContext.fetch(request)
            if !object.isEmpty {
                AppDelegate.viewContext.delete(object[0])
                try? AppDelegate.viewContext.save()
            }
        } catch _ as NSError {
        }
    }
    
    func checkIfFavorite(tweetID: String, completion: (Bool) -> Void) {
        let request: NSFetchRequest<TweetObject> = TweetObject.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", tweetID)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \TweetObject.id, ascending: true)]
        
        guard let tweet = try? AppDelegate.viewContext.fetch(request) else { print("error") ; return }
        
        if tweet == [] {completion(false); return }
        
        completion(true)
    }
    
    func removeAll() {

        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = TweetObject.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try AppDelegate.viewContext.execute(deleteRequest)
            try AppDelegate.viewContext.save()
        } catch {
        }
    }
}
