//
//  TweetCell.swift
//  NotificationDemoApp
//
//  Created by Margarita Blanc on 29/09/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    // MARK: - Properties
    
    private var viewModel: TweetCellViewModel!
    
    // MARK: - Outlets
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var liked: UILabel!
    
    @IBOutlet weak var retTweet: UILabel!
    
    @IBOutlet weak var tweetDate: UILabel!
    
    @IBOutlet weak var userName: UILabel!
    
    // MARK: - Public methods
    
    func updateCell(tweet: TweetItem) {
        self.tweetLabel.text = tweet.message
        guard let image = tweet.profilePicture.loadImage() else {return}
        self.profileImage.image = image
        customizeImage()
    }
    
    func configure(with viewModel: TweetCellViewModel) {
        self.viewModel = viewModel
        bind(to: self.viewModel)
        self.viewModel.configure()
    }
    
    func bind(to: TweetCellViewModel) {
        viewModel.tweetMessage = { [weak self] text in
            self?.tweetLabel.text = text
        }
        viewModel.liked = { [weak self] text in
            
            self?.liked.text = text
        }
        viewModel.tweetDate = { [weak self] date in
            self?.tweetDate.text = date
        }
        viewModel.userImage = { [weak self] image in
            guard let imageUI = image.loadImage() else {return}
            self?.profileImage.image = imageUI
            self?.customizeImage()
        }
        viewModel.userName = { [weak self] name in
            self?.userName.text = name
        }
        viewModel.retweet = { [weak self] retweet in
            self?.retTweet.text = retweet
        }
    }
    
    func customizeImage() {
        profileImage.layer.cornerRadius =
            (profileImage.frame.size.width)/2
        profileImage.layer.masksToBounds = true
        profileImage.layer.borderColor = #colorLiteral(red: 0.07982326299, green: 0.126388073, blue: 0.168425113, alpha: 1)
        profileImage.layer.borderWidth = 1
    }
}
