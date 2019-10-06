//
//  SearchViewModel.swift
//  NotificationDemoApp
//
//  Created by Margarita Blanc on 29/09/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

protocol TweetSearcViewModelDelegate: class {
    func displayAlert(type: AlertType)
    func didPresstweet(tweet: TweetItem)
}

enum LocationAuthorization {
    case authorized, denied
}

final class TweetSearchViewModel {
    
    // MARK: - Properties
    
    private weak var delegate: TweetSearcViewModelDelegate?
    
    private var repository: TweetSearchRepositoryType
    
    private var hashTag: String?
    
    private var latitude: String?
    
    private var longitude: String?
    
    private var persistence: Bool?
    
    private var switchButtonIsOn: Bool?
    
    private var geolocationIsAllowed: Bool?
    
    // MARK: - Init
    
    init(persistence: Persistence, delegate: TweetSearcViewModelDelegate, repository: TweetSearchRepositoryType) {
        
        self.delegate = delegate
        self.repository = repository
        
        switch persistence {
        case .favorite:
            self.persistence = true
        case .search:
            self.persistence = false
        }
    }
    
    // MARK: - Output
    
    var searchPlaceHolder: ((String) -> Void)?
    
    var tweets: (([TweetItem]) -> Void)?
    
    var hashtagLabel: ((String) -> Void)?
    
    var switchState: ((Bool) -> Void)?
    
    var switchHidden: (() -> Void)?
    
    // MARK: - Methods
    
    func viewDidAppear() {
        searchPlaceHolder?("Type a hashtag here 👊")
        switchState?(false)
        self.switchButtonIsOn = false
        if persistence == true {
            getSavedTweets()
        }
    }
    
    func didSelectTweet(tweet: TweetItem) {
        delegate?.didPresstweet(tweet: tweet)
    }
    
    func didWriteHashtag(text: String) {
        self.hashTag = text
        hashtagLabel?(text)
        if persistence == false {
            getOnlineTweets()
        } else {
            switchHidden?()
            checkIfSavedMatch(hashtag: text)
        }
    }
    
    
    func selectLocation() {
        guard geolocationIsAllowed == true else {delegate?.displayAlert(type: .noCoordinates); return}
        guard checkCoordinates() == true else {delegate?.displayAlert(type: .noCoordinates); return}
        
        switchButtonIsOn = true
        switchState?(true)
        getOnlineTweets()
    }
    
    func unSelectLocation() {
        switchButtonIsOn = false
        switchState?(false)
        getOnlineTweets()
    }
    
    func updateCoordinates(latitude: Double, longitude: Double) {
        self.latitude = "\(latitude)"
        self.longitude = "\(longitude)"
    }
    
    func updateAuthorization(status: LocationAuthorization) {
        if status == .authorized {
            self.geolocationIsAllowed = true
        }
        if status == .denied {
            self.geolocationIsAllowed = false
        }
    }
    
    private func checkCoordinates() -> Bool{
        guard self.latitude != nil else {return false}
        guard self.longitude != nil else {return false}
        return true
    }
    
    
    private func checkIfSavedMatch(hashtag: String) {
        let hashtagArray = hashtag.components(separatedBy: " ")
        repository.checkIfFavorite(hashtagArray: hashtagArray) { (array) in
            print(array)
            if array.isEmpty {delegate?.displayAlert(type: .noTweet)}
            self.tweets?(array)
            }
    }
    
    private func getOnlineTweets() {
        guard let hashTag = hashTag else {return}
        guard let hashTagNoSpace = hashTag.replaceSpaces() else {return}
        switch switchButtonIsOn {
        case true:
            guard let latitude = latitude else {return}
            guard let longitude = longitude else {return}
            
            repository.getTweets(hashTag: hashTagNoSpace, latitude: latitude, longitude: longitude, success: { (response) in
                switch response {
                case .success(value: let tweetArray):
                    self.tweets?(tweetArray)
                case .error:
                    self.delegate?.displayAlert(type: .networkError)
                }
            }) { (error) in
                print(error)
            }
            
        case false :
            repository.getTweets(hashTag: hashTagNoSpace, success: { (response) in
                switch response {
                case .success(value: let tweetArray):
                    self.tweets?(tweetArray)
                case .error:
                    print("error")
                    self.delegate?.displayAlert(type: .networkError)
                }
            }) { (error) in
                print(error)
            }
        default: break
        }
    }
    
    private func getSavedTweets() {
        repository.getSavedTweet(completion: { (response) in
            switch response {
            case .success(value: let tweetArray):
                self.tweets?(tweetArray)
            case .error:
                self.delegate?.displayAlert(type: .networkError)
            }
        })
    }
}
