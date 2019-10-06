//
//  DetailViewController.swift
//  NotificationDemoApp
//
//  Created by Margarita Blanc on 29/09/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
    var viewModel: TweetDetailViewModel!
    
    private let heart = UIImage(systemName: "heart")
    
    private let heartFill = UIImage(systemName: "heart.fill")
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var profileName: UILabel!
    
    @IBOutlet weak var tweetDate: UILabel!
    
    @IBOutlet weak var tweetMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind(to: viewModel)
        viewModel.viewDidLoad()
        configureUI()
    }
    
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
            guard let image = image.loadImage() else {print("ALERT"); return}
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
    }
    
    private func configureUI() {
        navigationItem.title = "👉Tweet Detail"
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        viewModel.didPressSave()
    }

}
