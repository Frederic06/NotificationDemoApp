//
//  TitleCell.swift
//  NotificationDemoApp
//
//  Created by Margarita Blanc on 30/09/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

protocol TitleCellDelegate: class {
    func didPressFilterLocation()
    func didPressUnFilterLocation()
}

import UIKit
import SwiftUI

class TitleCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let unselectedHeart = UIImage(systemName: "heart")
    
    private let selectedHeart = UIImage(systemName: "heart.fill")
    
    private let list = UIImage(systemName: "list.dash")
    
    private var viewModel: TitleCellViewModel!
    
    // MARK: - Outlets

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var hashtagTitle: UILabel!
    
    @IBOutlet weak var locationSwitch: UISwitch!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    // MARK: - Public methods
    
    func configure(with viewModel: TitleCellViewModel) {
        self.viewModel = viewModel
        bind(to: viewModel)
        self.viewModel.configure()
    }
    
    // MARK: - Private methods

    private func bind(to viewModel: TitleCellViewModel) {
        viewModel.hashtagLabel = { [weak self] text in
            self?.hashtagTitle.text = text
        }
        viewModel.locationStatus = { [weak self] status in
            switch status {
            case true:
                self?.locationSwitch.setOn(true, animated: false)
            case false:
                self?.locationSwitch.setOn(false, animated: false)
            }
        }
        viewModel.switchTitle = { [weak self] text in
            self?.locationLabel.text = text
        }
        viewModel.hideLocation = { [weak self] text in
            self?.locationSwitch.isHidden = true
            self?.locationLabel.isHidden = true
        }
        viewModel.activityShown = { [weak self] state in
            if state == true {
                self?.activityIndicator.startAnimating()
            } else {
                self?.activityIndicator.stopAnimating()
            }
        }
    }

    // MARK: - Actions

    @IBAction func didPressSwitch(_ sender: UISwitch) {
        viewModel.clickedOnLocationSwitch()
    }
}
