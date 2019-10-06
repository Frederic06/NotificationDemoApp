//
//  SearchCoordinator.swift
//  NotificationDemoApp
//
//  Created by Margarita Blanc on 03/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class SearchCoordinator {

// MARK: - Properties

private let presenter: UINavigationController
private let screens: Screens

// MARK: - Initializer

init(presenter: UINavigationController, screens: Screens) {
    self.presenter = presenter
    self.screens = screens
}

// MARK: - Coordinator

func start() {
    showSearch()
}
    private func showSearch() {
        let viewController = screens.createTwitterSearchViewController(persistence: .search, delegate: self)
        presenter.viewControllers = [viewController]
    }
    
    private func showTweetDetail(tweet: TweetItem) {
               print("showHashtags APPCOORDINATOR")
        let viewController = screens.createTweetDetailViewController(tweet: tweet, delegate: self)
        presenter.pushViewController(viewController, animated: true)
    }
    
    private func showAlert(for type: AlertType) {
        guard let alert = screens.createAlert(for: type) else {return}
            if let popoverController = alert.popoverPresentationController {
          popoverController.sourceView = presenter.view
          popoverController.sourceRect = CGRect(x: presenter.view.bounds.midX, y: presenter.view.bounds.midY, width: 0, height: 0)
          popoverController.permittedArrowDirections = []
        }
        
        presenter.visibleViewController?.present(alert, animated: true, completion: nil)
    }
}

extension SearchCoordinator: TweetSearcViewModelDelegate {
    
    func didPresstweet(tweet: TweetItem) {
        showTweetDetail(tweet: tweet)
    }

    func displayAlert(type: AlertType) {
        showAlert(for: type)
    }
}

extension SearchCoordinator: TweetDetailViewModelDelegate {
    func displayAlarm(type: AlertType) {
    }
    
    func didPressFavorite(tweet: TweetItem) {
    }
}
