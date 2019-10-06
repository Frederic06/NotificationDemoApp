//
//  TwitterSearchDataSource.swift
//  NotificationDemoApp
//
//  Created by Margarita Blanc on 29/09/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class TweetSearchDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Private properties
    
    private var hashtag: String? = nil
    private var tweetArray: [TweetItem]? = nil
    private var buttonFavoriteListText: String? = nil
    private var switchState: Bool = false
    private var switchHidden: Bool = false
    
    // MARK: - Public properties
    
    var didSelectLocalisation: (() -> Void)?
    
    var didUnselectLocalisation: (() -> Void)?
    
    var didSelectTweet: ((TweetItem) -> Void)?
    
    func udpate(hashtag: String) {
        self.hashtag = hashtag
    }
    
    func update(text: String) {
        self.buttonFavoriteListText = text
    }
    
    func update(tweets: [TweetItem]) {
        self.tweetArray = tweets
    }
    
    func update(switchState: Bool) {
        self.switchState = switchState
    }
    
    func update(switchHidden: Bool) {
        self.switchHidden = switchHidden
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tweets = tweetArray else { return 0}
        switch section {
        case 0:
            guard hashtag != nil else {return 0}
            return 1
        case 1:
            return tweets.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        switch indexPath.section {
        case 0:
            guard let hashtagText = hashtag else {return cell}
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath)as! TitleCell
            tableView.rowHeight = 100
            let viewModel = TitleCellViewModel(delegate: self, hashTag: hashtagText, switchState: switchState, switchHidden: switchHidden)
            cell.configure(with: viewModel)
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath)as! TweetCell
            tableView.rowHeight = 200
            guard let tweets = tweetArray else { return cell}
            cell.updateCell(tweet: tweets[indexPath.row])
            return cell
            
        default:
            print("Default Selected")
        }
        return cell
    }
}

extension TweetSearchDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tweet = tweetArray?[indexPath.row] else {print("alert"); return}
        self.didSelectTweet?(tweet)
    }
}

extension TweetSearchDataSource: TitleCellDelegate {
    func didPressHashTagList() {
    }
    
    func didPressFilterLocation() {
        didSelectLocalisation?()
    }
    
    func didPressUnFilterLocation() {
        didUnselectLocalisation?()
    }
}
