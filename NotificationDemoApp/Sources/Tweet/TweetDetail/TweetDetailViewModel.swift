//
//  TweetDetailViewModel.swift
//  NotificationDemoApp
//
//  Created by Margarita Blanc on 03/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

    // MARK - Protocols

protocol TweetDetailViewModelDelegate: class {
    func displayAlarm(type: AlertType)
}

final class TweetDetailViewModel {
    
    // MARK: - Properties
    
    private weak var delegate: TweetDetailViewModelDelegate?
    
    private var repository: TweetDetailRepositoryType
    
    private var tweet: TweetItem
    
    private var isFavorite: Bool?
    
    // MARK: - Init
    
    init(delegate: TweetDetailViewModelDelegate?, repository: TweetDetailRepositoryType, tweet: TweetItem) {
        self.delegate = delegate
        self.repository = repository
        self.tweet = tweet
        
        repository.checkIfFavorite(tweetID: tweet.id) { (state) in
            self.isFavorite = state
        }
    }
    
    // MARK: - Output
    
    var savedButton: ((Bool) -> Void)?
    
    var profilePictureString: ((String) -> Void)?
    
    var profileNameText: ((String) -> Void)?
    
    var tweetDate: ((String) -> Void)?
    
    var tweetMessage: ((String) -> Void)?
    
    var liked: ((String) -> Void)?
    
    var retweet: ((String) -> Void)?
    
    // MARK: - Methods
    
    func viewDidLoad() {
        guard let favorite = isFavorite else {return}
        savedButton?(favorite)
        profilePictureString?(tweet.profilePicture)
        profileNameText?(tweet.userName)
        tweetDate?(tweet.date)
        tweetMessage?(tweet.message)
        liked?("♡ \(tweet.liked)")
        retweet?("⮑ \(tweet.retweet)")
    }
    
    func didPressSave(){
        print("did press save")
        if isFavorite == true {
        repository.removeFavorite(tweetID: tweet.id)
            isFavorite = false
        } else {
            repository.saveTweet(tweet: tweet)
            isFavorite = true
        }
        guard let favorite = isFavorite else {return}
        savedButton?(favorite)
    }
}

