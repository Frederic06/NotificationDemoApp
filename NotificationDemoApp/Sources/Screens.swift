//
//  Screens.swift
//  NotificationDemoApp
//
//  Created by Margarita Blanc on 28/09/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class Screens {
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: Screens.self))
}

enum Persistence {
    case favorite, search
}

// MARK: - Search

extension Screens {
    func createTwitterSearchViewController(persistence: Persistence, delegate: TweetSearcViewModelDelegate) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "TweetSearchViewController") as! TweetSearchViewController
        let network = Network()
        let repository = TweetSearchRepository(network: network)
        let viewModel = TweetSearchViewModel(persistence: persistence, delegate: delegate, repository: repository)
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK: - Detail

extension Screens {
    func createTweetDetailViewController(tweet: TweetItem, delegate: TweetDetailViewModelDelegate) -> UIViewController {
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "TweetDetailViewController") as! TweetDetailViewController
        let repository = TweetDetailRepository()
        let viewModel = TweetDetailViewModel(delegate: delegate, repository: repository, tweet: tweet)
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK: - Alert

extension Screens {
    func createAlert(for type: AlertType) -> UIAlertController? {
        let alert = Alert(type: type)
        let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .actionSheet)
        let yesButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(yesButton)
        return alertController
    }
}
