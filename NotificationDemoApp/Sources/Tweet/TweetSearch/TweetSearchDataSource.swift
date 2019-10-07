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
    
    private var lastContentOffset: CGFloat = 0
    
    private var animating: Bool = false
    
    // MARK: - Outputs
    
    var didSelectLocalisation: (() -> Void)?
    
    var didUnselectLocalisation: (() -> Void)?
    
    var didSelectTweet: ((TweetItem) -> Void)?
    
    // MARK: - Public methods
    
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
            tableView.rowHeight = 130
            let viewModel = TitleCellViewModel(delegate: self, hashTag: hashtagText, switchState: switchState, switchHidden: switchHidden)
            cell.configure(with: viewModel)
            return cell
            
        case 1:
            guard let tweets = tweetArray else { return cell}
            let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath)as! TweetCell
            let viewModel = TweetCellViewModel(tweet: tweets[indexPath.row], index: indexPath.row)
            tableView.rowHeight = 200
            
            cell.configure(with: viewModel)
            return cell
            
        default: break
        }
        return cell
    }
}

    // MARK: - Extensions

extension TweetSearchDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tweet = tweetArray?[indexPath.row] else { return }
        self.didSelectTweet?(tweet)
    }
}

extension TweetSearchDataSource: TitleCellDelegate {
    func didPressFilterLocation() {
        didSelectLocalisation?()
    }
    
    func didPressUnFilterLocation() {
        didUnselectLocalisation?()
    }
}

extension TweetSearchDataSource: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset > scrollView.contentOffset.y) {
        }
    }
}
