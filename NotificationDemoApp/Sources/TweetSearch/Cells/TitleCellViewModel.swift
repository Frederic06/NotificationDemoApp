//
//  TitleCellViewModel.swift
//  NotificationDemoApp
//
//  Created by Margarita Blanc on 02/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

final class TitleCellViewModel {
    
    //     MARK: - Properties
    
    private weak var delegate: TitleCellDelegate?
    
    private var hashTag: String? = nil
    
    private var switchState: Bool
    
    private var switchHidden: Bool
    
    // MARK: - Initializer
    
    init(delegate: TitleCellDelegate?, hashTag: String, switchState: Bool, switchHidden: Bool) {
        self.delegate = delegate
        self.hashTag = hashTag
        self.switchState = switchState
        self.switchHidden = switchHidden
    }
    
    // MARK: - Outputs
    
    var hashtagLabel: ((String) -> Void)?
    
    var switchTitle: ((String) -> Void)?
    
    var locationStatus: ((Bool) -> Void)?
    
    var hideLocation: ((String) -> Void)?
    
    // MARK: - Inputs
    func configure() {
        guard let hashTag = hashTag else {return}
        hashtagLabel?("Recent tweets for : #\(hashTag)")
        switchTitle?("Would you search around you?")
        locationStatus?(switchState)
        if switchHidden == true {
            hideLocation?("true")
        }
    }
    
    func clickedOnLocationSwitch() {
        if switchState == true {delegate?.didPressUnFilterLocation()}
        if switchState == false {delegate?.didPressFilterLocation()}
    }
}
