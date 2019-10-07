//
//  DetailViewController.swift
//  NotificationDemoApp
//
//  Created by Margarita Blanc on 29/09/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: TweetDetailViewModel!
    
    private let heart = UIImage(systemName: "heart")
    
    private let heartFill = UIImage(systemName: "heart.fill")
    
    // MARK: - Outlets
    
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var profileName: UILabel!
    
    @IBOutlet weak var tweetDate: UILabel!
    
    @IBOutlet weak var tweetMessage: UILabel!
    
    @IBOutlet weak var retweet: UILabel!
    
    @IBOutlet weak var liked: UILabel!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind(to: viewModel)
        viewModel.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Public methods
    
    func bind(to viewModel: TweetDetailViewModel) {
        
        viewModel.savedButton = { [weak self] state in
            switch state {
            case true:
                self?.saveButton.setImage(self?.heartFill, for: .normal)
            case false:
                self?.saveButton.setImage(self?.heart, for: .normal)
            }
        }
        viewModel.profilePictureString = { [weak self] image in
            guard let image = image.loadImage() else { return }
            self?.profileImage.image = image
            self?.profileImage.setRounded()
        }
        viewModel.profileNameText = { [weak self] name in
            self?.profileName.text = name
        }
        viewModel.tweetDate = { [weak self] date in
            self?.tweetDate.text = date
        }
        viewModel.tweetMessage = { [weak self] message in
            self?.tweetMessage.text = message
        }
        viewModel.liked = { [weak self] text in
            self?.liked.text = text
        }
        viewModel.retweet = { [weak self] text in
            self?.retweet.text = text
        }
        

    }
    
    // MARK: - Private methods
    
    private func configureUI() {
        navigationItem.title = "👉Tweet Detail"
    }
    
    // MARK: - Actions
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        viewModel.didPressSave()
    }
    
}
