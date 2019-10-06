//
//  TitleCell.swift
//  NotificationDemoApp
//
//  Created by Margarita Blanc on 30/09/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

protocol TitleCellDelegate: class {
    func didPressHashTagList()
    func didPressFilterLocation()
    func didPressUnFilterLocation()
}

import UIKit
import SwiftUI

class TitleCell: UITableViewCell {
    
    private let unselectedHeart = UIImage(systemName: "heart")
    private let selectedHeart = UIImage(systemName: "heart.fill")
    private let list = UIImage(systemName: "list.dash")
    
    private var viewModel: TitleCellViewModel!

    @IBOutlet weak var hashtagTitle: UILabel!
    
    @IBOutlet weak var locationSwitch: UISwitch!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    func configure(with viewModel: TitleCellViewModel) {
        self.viewModel = viewModel
        bind(to: self.viewModel)
        self.viewModel.configure()
    }

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
    }


    @IBAction func didPressSwitch(_ sender: UISwitch) {
        viewModel.clickedOnLocationSwitch()
    }
    
}
