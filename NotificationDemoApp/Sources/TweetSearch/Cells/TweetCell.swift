//
//  TweetCell.swift
//  NotificationDemoApp
//
//  Created by Margarita Blanc on 29/09/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var tweetLabel: UILabel!
    
    func updateCell(tweet: TweetItem) {
        self.tweetLabel.text = tweet.message
        guard let image = tweet.profilePicture.loadImage() else {return}
        self.profileImage.image = image
        customizeImage()
    }
    
    func customizeImage() {
//        self.profileImage.setRounded()
        profileImage.layer.cornerRadius =
            (profileImage.frame.size.width)/2
        
         profileImage.layer.masksToBounds = true
        
         profileImage.layer.borderColor = #colorLiteral(red: 0.07982326299, green: 0.126388073, blue: 0.168425113, alpha: 1)
         profileImage.layer.borderWidth = 1
    }
    
}
